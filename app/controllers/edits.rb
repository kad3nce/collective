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
  def update(id)
    provides :js, :json
    @edit = Version.first(id) || raise(NotFound)
    if @edit.update_attributes(:moderated => true)
      train_spam_engine(@edit)
      if request.xhr?
        render '', :status => 200 # renders nothing
      else
        redirect url(:edits)
      end
    else
      raise BadRequest
    end
  end
  
private

  def authenticate
    authenticate_or_request_with_http_basic('login') do |username, password|
      username == 'admin' && password == 'supersecret'
    end
  end

  def train_spam_engine(version)
    if Viking.enabled?
      if (version.spam?)
        Viking.mark_as_ham(:signatures => version.signature)
      else
        Viking.mark_as_spam(:signatures => version.signature)
      end
    end
  end

end
