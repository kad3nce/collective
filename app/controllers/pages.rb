class Pages < Application
  include(Viking.enabled? ? SpamProtection : NoSpamProtection)
  
  def index
    @pages = Page.all
    display @pages
  end

  def show(id, version = :latest)
    @page = Page.by_slug_and_select_version!(id, version) || raise(NotFound)
    display @page
  end

  def new
    @page = Page.new(:name => 'New Page')
    render
  end

  def edit(id, version = :latest)
    @page = Page.by_slug_and_select_version!(id, version) || raise(NotFound)
    render
  end
end
