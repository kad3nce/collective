module MerbHasFlash
  module ControllerExtension
    def self.included(base)
      base.send :include, InstanceMethods
      
      base.class_eval {
        after :sweep_flash
      }
    end
    
    module InstanceMethods
      # Access the contents of the flash. Use <tt>flash["notice"]</tt> to read a notice you put there or 
      # <tt>flash["notice"] = "hello"</tt> to put a new one.
      # Note that if sessions are disabled only flash.now will work.
      def flash(refresh = false) #:doc:
        if !defined?(@_flash) || refresh
          @_flash =
            if session.is_a?(Hash)
              # don't put flash in session if disabled
              FlashHash.new
            else
              # otherwise, session is a CGI::Session or a TestSession
              # so make sure it gets retrieved from/saved to session storage after request processing
              session["flash"] ||= FlashHash.new
            end
        end

        @_flash
      end
      
      protected
      def sweep_flash
        flash.sweep if request.session
        session["flash"] = flash
      end
    end
  end
end
