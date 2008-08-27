class Edits < Application

  before :authenticate, :exclude => [:show]

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
    train_spam_engine(@edit)
    if request.xhr?
      render '', :status => 200, :layout => false # renders nothing
    else
      redirect url(:edits)
    end
  end

  # Accessed by: GET /edits/permalink_to
  def show(id)
    @page = Page.by_slug(id) || raise(NotFound)
    display @page
  end
  
private

  def authenticate
    basic_authentication('Merb Wiki') do |username, password|
      username == Collective.admin_username && password == Collective.admin_password
    end
  end

  def train_spam_engine(version)
    if Viking.enabled?
      if (version.spam?)
        Viking.mark_as_ham(:signatures => version.signature)
        version.update_attributes(:spam => false, :moderated => true)
      else
        Viking.mark_as_spam(:signatures => version.signature)
        version.update_attributes(:spam => true, :moderated => true)
      end
    end
  end

end
