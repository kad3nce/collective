# ========================================================
# = TODO: Use action-args after the next release of Merb =
# ========================================================
module NoSpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  # Accessed by: POST /pages
  def create
    @page = Page.new(params[:page])
    @version = Version.new(params[:version])
    if @page.valid? && @version.valid?
      @page.versions << @version
      @page.save
      redirect url(:page, @page)
    else
      render :new
    end
  end

  # Accessed by: PUT /pages/1
  def update
    @page = Page.by_slug(params[:id]) || raise(NotFound)
    @page.versions << @version = Version.new(params[:version])
    if @version.save
      redirect url(:page, @page)
    else
      flash[:notice] = 'Your changes have been rejected.'
      render :edit
    end
  end
end