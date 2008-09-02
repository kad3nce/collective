class Sessions < Application
  def new
    render
  end

  def create
    
    if openid_request?
      openid_authenticate(:sreg => [:fullname]) do |result, identity_url, sreg|
        if result == :successful
          @user = User.first(:openid_url => identity_url) || User.create(:openid_url => identity_url, :name => sreg['fullname'])
          session[:user_id] = @user.id
          redirect(params[:destination] || '/')
        else
          @_message = "Your login failed with the following status: #{result}"
          render :new
        end
      end
    else
      redirect(url(:new_session), :message => 'Malformed request. Please try again.')
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect '/'
  end

end # Sessions
