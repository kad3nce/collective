module Viking
  class Base
    attr_reader :options

    def initialize(options)
      self.options = options
    end

    def verified?
    end

    def check_article(options={})
    end

    def check_comment(options={})
    end
  
    def mark_as_spam(options={})
    end
  
    def mark_as_ham(options={})
    end
    
    def stats
    end

    def self.logger
      Viking.logger
    end
    
    def logger
      Viking.logger
    end
    
    # Checks to ensure that the minimum number of +options+ have been provided 
    # to make a call to the spam protection service.
    # 
    # Required options include:
    # * +api_key+
    # * +blog+
    # 
    # See the module for your desired spam protection service for details on 
    # the format of these options.
    def invalid_options?
      options[:api_key].nil? || options[:blog].nil?
    end
    
    protected
      def log_request(url, data, response)
        return unless logger
        logger.info("[#{self.class.name}] POST '%s' with %s" % [url, data])
        logger.debug(">> #{response.body.inspect}")
      end
  end
end