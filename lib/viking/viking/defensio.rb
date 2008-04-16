require 'net/http'
require 'uri'
require 'yaml'

module Viking
  class Defensio < Base
    class << self
      attr_accessor :host, :port, :api_version, :standard_headers, :service_type
    end
    
    attr_accessor :proxy_port, :proxy_host
    attr_reader :last_response

    self.service_type     = :blog
    self.host             = 'api.defensio.com'
    self.api_version      = '1.1'
    self.standard_headers = {
      'User-Agent'   => 'Viking (Rails Plugin) v0.5',
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  
    # Create a new instance of the Akismet class
    #
    # ==== Arguments
    # Arguments are provided in the form of a Hash with the following keys 
    # (as Symbols) available: 
    # 
    # +api_key+::    your Defensio API key
    # +blog+::       the blog associated with your api key
    # 
    # The following keys are available and are entirely optional. They are 
    # available incase communication with Akismet's servers requires a 
    # proxy port and/or host:
    # 
    # * +proxy_port+
    # * +proxy_host+
    def initialize(options)
      super
      self.verify_options = false
    end

    # Returns +true+ if the API key has been verified, +false+ otherwise
    def verified?
      (verify_options ||= call_defensio('validate-key'))[:status] == 'success'
    end

    def check_article(options={})
      return false if invalid_options?
      call_defensio 'announce-article', options
    end

    def check_comment(options={})
      return false if invalid_options?
      if options[:article_date].respond_to?(:strftime)
        options[:article_date] = options[:article_date].defensio_date_format
      end
      call_defensio 'audit-comment', options
    end
  
    def mark_as_spam(options={})
      return false if invalid_options?
      call_defensio 'report-false-negatives', options
    end
  
    def mark_as_ham(options={})
      return false if invalid_options?
      call_defensio 'report-false-positives', options
    end
  
    def stats
      return false if invalid_options?
      call_defensio 'get-stats'
    end

    protected
      def api_url(action)
        URI.escape("/#{self.class.service_type}/#{self.class.api_version}/#{action}/#{options[:api_key]}.yaml")
      end

      def call_defensio(action, params={})
        resp = defensio_http.post(
          api_url(action), 
          data(params), 
          self.class.standard_headers
        )
        log_request(api_url(action), data, resp)
        process_response_body(resp.body)
      end
      
      def process_response_body(response_body)
        data = YAML.load(response_body)
        if data.respond_to?(:key) && data.key?('defensio-result')
          data['defensio-result'].symbolize_keys
        else
          { :data => raw_data, :status => 'fail' }
        end
      end
      
      def defensio_http
        Net::HTTP.new(
          self.class.host, 
          self.class.port, 
          options[:proxy_host], 
          options[:proxy_port]
        )
      end
      
      def data(params={})
        params.
          update('owner-url' => options[:blog] || options[:owner_url]).
          dasherize_keys.
          to_query
      end
      
    private
      attr_accessor :verify_options
  end
end