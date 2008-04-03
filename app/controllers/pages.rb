class Pages < Application
  def index
    @pages = Page.all
    display @pages
  end

               # I wonder if merb-action-args could conceivably support nil defaults (i.e. version = nil)
  def show(id, version = :latest)
    @page = Page.first(:slug => id)
    @page.select_version!(version.to_i) unless version == :latest
    raise NotFound unless @page
    display @page
  end

  def new
    @page = Page.new
    render
  end

  def edit(id, version = :latest)
    @page = Page.first(:slug => id)
    @page.select_version!(version.to_i) unless version == :latest
    raise NotFound unless @page
    render
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect url(:page, @page)
    else
      render :new
    end
  end

  def update(id)
    @page = Page.first(:slug => id)
    raise NotFound unless @page
    if @page.update_attributes(:content => params[:page][:content])
      redirect url(:page, @page)
    else
      raise BadRequest
    end
  end
end
