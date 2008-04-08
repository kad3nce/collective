class Edits < Application
  before :authenticate

  def index
    @edits = Version.all(:moderated => false, :limit => 100, :order => 'created_at DESC')
    display @edits
  end

  def update
    @edit = Version.first(params[:id])
    raise NotFound unless @edit
    if @edit.update_attributes(:moderated => true)
      if(@edit.spam)
        # send @edit.signature to Defensio with #report-false-positives
      else
        # send @edit.signature to Defensio with #report-false-negatives
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
