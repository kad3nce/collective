class Edits < Application  
  before :authenticate

  # Accessed by: GET /edits
  #--
  # FIXME What happens if we get here and there are no edits?
  def index
    @edits = Version.most_recent_unmoderated
    display @edits
  end

  # Accessed by: PUT /edits/1
  def update
    @edit = Version.first(params[:id])
    raise NotFound unless @edit
    if(@edit.spam)
      DEFENSIO_GATEWAY.mark_as_ham(:signatures => @edit.signature)
    else
      DEFENSIO_GATEWAY.mark_as_spam(:signatures => @edit.signature)
    end
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
