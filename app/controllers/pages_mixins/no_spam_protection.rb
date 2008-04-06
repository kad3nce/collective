# =========================================================================
# = TODO: Figure out a way to get action-args to work on mixed in actions =
# =========================================================================
module NoSpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  def create
    @page = Page.new params[:page]
    if @page.save
      redirect url(:page, @page)
    else
      render :new
    end
  end

  def update
    @page = Page.first(:slug => params[:id]) || raise(NotFound)
    if @page.update_attributes(:content => params[:page][:content])
      redirect url(:page, @page)
    else
      raise BadRequest
    end
  end
end