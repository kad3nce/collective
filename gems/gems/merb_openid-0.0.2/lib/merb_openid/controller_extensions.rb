require 'openid'
require 'openid/extensions/sreg'
require 'openid/store/memory'

module MerbOpenID
  
  def self.store
    @@store
  end
  
  def self.store=(val)
    @@store = val
  end 
  
  module ControllerExtensions
    
    def openid_request?(open_id_param=params[:openid_url])
      !!((open_id_param && !open_id_param.blank?) || params[:openid_complete])
    end
    
    def openid_authenticate(options={}, &block)
      open_id_param = options.delete(:open_id_param) || params[:openid_url]
      
      unless params[:openid_complete]
        begin_openid_authentication(open_id_param, options, &block)
      else
        complete_openid_authentication(&block)
      end
    end
    
    def openid_consumer
      @@openid_consumer ||= OpenID::Consumer.new session, MerbOpenID.store
    end
    
    private
    
    def begin_openid_authentication(openid_url, options={})
      fields = options[:sreg] || {}
      immediate = (options[:immediate] === true)
      
      request = openid_consumer.begin(openid_url)
      
      add_sreg_fields(request, fields)
      
      redirect openid_provider_url(request, immediate)
      
    rescue OpenID::OpenIDError, Timeout::Error
      yield :missing
    end
    
    def complete_openid_authentication
      query_string_params = Merb::Request.query_parse(request.query_string)
      
      begin
        response = openid_consumer.complete(query_string_params, openid_return_to)
        identity_url = response.endpoint.claimed_id
        
        case response.status
          when OpenID::Consumer::SUCCESS
            yield :successful, identity_url, OpenID::SReg::Response.from_success_response(response)
          when OpenID::Consumer::CANCEL
            yield :cancelled, identity_url, nil
          when OpenID::Consumer::FAILURE
            yield :failed, identity_url, nil
          when OpenID::Consumer::SETUP_NEEDED
            yield :setup_needed, identity_url, response.setup_url
        end
      rescue Timeout::Error
        yield :failed
      end
    end
    
    def add_sreg_fields(request, fields)
      if fields.is_a?(Array)
        required, optional = fields, []
      else
        required = fields[:required] || []
        optional = fields[:optional] || []
      end
      
      sreg = OpenID::SReg::Request.new
      
      sreg.request_fields(required.collect { |f| f.to_s }, true) unless required.empty?
      sreg.request_fields(optional.collect { |f| f.to_s }, false) unless optional.empty?
      
      request.add_extension(sreg)
    end
    
    def openid_provider_url(request, immediate)
      request.return_to_args['openid_complete'] = '1'
      request.redirect_url(openid_trust_root, openid_return_to, immediate)
    end
    
    def openid_trust_root
      @openid_trust_root ||= [request.protocol, request.host, "/"].join
    end
    
    def openid_return_to
      @openid_return_to ||= [request.protocol, request.host, request.uri].join
    end
    
  end
  
end

Merb::Controller.class_eval do
  include MerbOpenID::ControllerExtensions
end

MerbOpenID.store = (Merb::Config[:merb_openid] && Merb::Config[:merb_openid][:store]) || OpenID::Store::Memory.new