class Pages < Application 
  include(Viking.enabled? ? SpamProtection : NoSpamProtection)
  
  # Accessed by: GET /pages
  def index
    @pages = Page.all
    display @pages
  end

  # Accessed by: 
  # - GET /pages/1
  # - GET /pages/1?version=3
  def show(id, version = :latest)
    @page = Page.by_slug_and_select_version!(id, version) || raise(NotFound)
    display @page
  end

  # Accessed by: GET /pages/new
  def new(page = 'New Page')
    @page = Page.new(:name => page)
    render
  end

  # Accessed by: 
  # - GET /pages/1/edit
  # - GET /pages/1/edit?version=3
  def edit(id, version = :latest)
    @page = Page.by_slug_and_select_version!(id, version) || raise(NotFound)
    render
  end
end
