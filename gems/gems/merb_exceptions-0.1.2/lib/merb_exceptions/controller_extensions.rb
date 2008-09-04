module MerbExceptions
  module ControllerExtensions
    
    def self.included(mod)
      mod.class_eval do
        def internal_server_error
          # These two variables are required by the default exception template
          @exception = self.params[:exception]
          @exception_name = @exception.name.split("_").map {|x| x.capitalize}.join(" ")
          self.render_and_notify :layout=>false
        end
      end
    end
    

    def render_and_notify(opts={})
      self.render_then_call(render(opts)) { notify_of_exceptions }
    end

    def notify_of_exceptions
      exception = self.params[:exception]
      request = self.request
      orig_params = self.params[:original_params]
      details = {}
      details['exception']       = exception
      details['params']          = orig_params
      details['environment']     = request.env.merge( 'process' => $$ )
      details['url']             = "#{request.protocol}#{request.env["HTTP_HOST"]}#{request.uri}"
      MerbExceptions::Notification.new(details).deliver!
    end
  end
end