class Pages < Application
  include NoSpamProtection
  # include DefensioSpamProtection
  
  def index
    @pages = Page.all
    display @pages
  end

  def show(id, version = :latest)
    @page = Page.first(:slug => id) || raise(NotFound)
    @page.select_version!(version.to_i) unless version == :latest
    display @page
  end

  def new
    @page = Page.new
    render
  end

  def edit(id, version = :latest)
    @page = Page.first(:slug => id) || raise(NotFound)
    @page.select_version!(version.to_i) unless version == :latest
    render
  end
end
