# =================================================
# = Temporary Core Extensions to make Viking work =
# =================================================
require 'cgi'

class Object
  def to_query(key)
    "#{CGI.escape(key.to_s)}=#{CGI.escape(to_param.to_s)}"
  end

  def to_param
    to_s
  end
end

class String
  def dasherize
    self.gsub(/_/, '-')
  end
end

class Hash
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end
  
  def dasherize_keys
    inject({}) do |options, (key, value)|
      options[key.dasherize] = value
      options
    end
  end
  
  def to_query(namespace = nil)
    collect do |key, value|
      value.to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * '&'
  end
end

class Time
  def defensio_date_format
    strftime("%Y/%m/%d")
  end
end

# =================================
# = End Temporary Core Extensions =
# =================================

$:.unshift(File.dirname(__FILE__))
module Viking
  class Error < StandardError; end
  
  class << self
    attr_accessor :logger
    attr_accessor :default_engine
    attr_accessor :connect_options
    attr_writer   :default_instance

    def default_instance
      @default_instance ||= connect(default_engine, connect_options)
    end
    
    def enabled?
      !default_instance.nil?
    end
  
    def connect(engine, options)
      unless engine.nil? || engine.empty?
        require "viking/#{engine}"
        Viking.const_get(engine.to_s.capitalize).new(options)
      end
    end
    
    def verified?()               default_instance.verified?;              end
    def check_article(options={}) default_instance.check_article(options); end
    def check_comment(options={}) default_instance.check_comment(options); end
    def mark_as_spam(options={})  default_instance.mark_as_spam(options);  end
    def mark_as_ham(options={})   default_instance.mark_as_ham(options);   end
    def stats()                   default_instance.stats;                  end
    
    def mark_as_spam_or_ham(is_spam, options={})
      default_instance.mark_as_spam_or_ham(is_spam, options)
    end
  end
end

require 'viking/base'