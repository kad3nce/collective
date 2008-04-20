require 'ruby-debug'

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
    if @page.save
      redirect url(:page, @page)
    else
      render :new
    end
  end

  # Accessed by: PUT /pages/1
  def update
    @page = Page.by_slug(params[:id]) || raise(NotFound)
    if @page.update_attributes(params[:page])
      redirect url(:page, @page)
    else
      flash[:notice] = 'Your changes have been rejected.'
      render :edit
    end
  end
end