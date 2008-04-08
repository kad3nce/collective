class Edits < Application
  
  before :authenticate

  #--
  # FIXME What happens if we get here and there are no edits?
  def index
    @edits = Version.all(:moderated => false, :limit => 100, :order => 'created_at DESC')
    display @edits
  end

  def update
    @edit = Version.first(params[:id])
    raise NotFound unless @edit
    if @edit.update_attributes(:moderated => true)
      if(@edit.spam)
        DEFENSIO_GATEWAY.mark_as_ham(:signatures => @edit.signature)
      else
        DEFENSIO_GATEWAY.mark_as_spam(:signatures => @edit.signature)
      end
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
