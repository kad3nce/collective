class Application < Merb::Controller
  before :set_user
  
protected

  def set_user
    if session[:user_id]
      @user = User.get(session[:user_id])
    end
    
    @user = User.first(:name => 'Anonymous') unless @user
  end
  
end