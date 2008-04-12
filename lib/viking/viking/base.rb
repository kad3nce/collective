module Viking
  class Base
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def verified?
    end

    def check_article(options = {})
    end

    def check_comment(options = {})
    end
  
    # Provides a fuzzy interface to marking as either spam or ham based upon 
    # a boolean switch, +is_spam+. When +is_spam+ is true, +mark_as_spam+ is 
    # used. +mark_as_ham+ is used if +is_spam+ is false.
    # 
    # ==== Arguments
    # +is_spam+ <Boolean>:: the switch that determines the method to use
    # +options+ <Hash>:: options for your gateway of choice
    def mark_as(is_spam, options = {})
      is_spam ? mark_as_spam(options) : mark_as_ham(options)
    end
  
    def mark_as_spam(options = {})
    end
  
    def mark_as_ham(options = {})
    end
    
    def stats
    end

    def self.logger
      Viking.logger
    end
    
    def logger
      Viking.logger
    end
    
    protected
      def log_request(url, data, response)
        return unless logger
        logger.info("[#{self.class.name}] POST '%s' with %s" % [url, data])
        logger.debug(">> #{response.body.inspect}")
      end
  end
end