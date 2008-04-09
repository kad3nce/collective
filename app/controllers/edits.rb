class Edits < Application
  
  #--
  # FIXME What happens if we're not authenticated?
  before :authenticate

  #--
  # FIXME What happens if we get here and there are no edits?
  def index
    @edits = Version.most_recent_unmoderated
    display @edits
  end

  def update
    @edit = Version.first(params[:id])
    raise NotFound unless @edit
    if @edit.update_attributes(:moderated => true)
      if request.xhr?
        render :nothing => 200
      else
        redirect url(:edits)
      end
    else
      raise BadRequest
    end
  end
  
private

  def authenticate
    authenticate_or_request_with_http_basic("login") do |username, password|
      # ==============================================================================
      # = TODO: load password from an external file (set in place during deployment) =
      # ==============================================================================
      username == "merbivore" && password == "supersecret"
    end
  end

end
