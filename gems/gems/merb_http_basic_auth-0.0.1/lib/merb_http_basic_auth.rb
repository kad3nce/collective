# make sure we're running inside Merb
if defined?(Merb::Plugins)
  
  Merb::BootLoader.after_app_loads do
    Application.send(:include, HttpAuthentication)
  end
  
end

require 'base64'

module HttpAuthentication

  class << self
    
    def authentication_request(controller, realm)
      controller.headers["WWW-Authenticate"] = %(Basic realm="#{realm.gsub(/"/, "")}")
      throw :halt, controller.render("HTTP Basic: Access denied.\n", :status => "401 Unauthorized", :layout => false)
    end
    
    def authenticate(controller, &login_procedure)
      
      auth_token = get_auth_token(controller.request)
      
      if auth_token.blank?
        return false
      else
        return login_procedure.call(*user_name_and_password(auth_token))
      end
    end
    
    protected
    
    def user_name_and_password(auth_token)
      Base64.decode64(auth_token.split.last || '').split(/:/, 2)
    end

    def get_auth_token(request)
      request.env['HTTP_AUTHORIZATION']   ||
      request.env['X-HTTP_AUTHORIZATION'] ||
      request.env['X_HTTP_AUTHORIZATION'] ||
      request.env['REDIRECT_X_HTTP_AUTHORIZATION']
    end

  end
 
  def authenticate_or_request_with_http_basic(realm = "Application", &login_procedure)
    authenticate_with_http_basic(&login_procedure) || request_http_basic_authentication(realm)
  end

  def authenticate_with_http_basic(&login_procedure)
    HttpAuthentication.authenticate(self, &login_procedure)
  end

  def request_http_basic_authentication(realm = "Application")
    HttpAuthentication.authentication_request(self, realm)
  end
  
end