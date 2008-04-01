class Pages < Application
  def index
    @pages = Page.all
    display @pages
  end

  def show(id)
    @page = Page.first(:slug => id)
    raise NotFound unless @page
    display @page
  end

  def new
    @page = Page.new
    render
  end

  def edit(id)
    @page = Page.first(:slug => id)
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
    if @page.update_attributes(params[:page])
      redirect url(:page, @page)
    else
      raise BadRequest
    end
  end

  def destroy
    @page = Page.first(params[:id])
    raise NotFound unless @page
    if @page.destroy!
      redirect url(:page)
    else
      raise BadRequest
    end
  end

end
