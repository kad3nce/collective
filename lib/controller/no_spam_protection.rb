module NoSpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  # Accessed by: POST /pages
  def create(page, version)
    @page = Page.new(page)
    @version = Version.new(version.merge(:user => @user))
    if @page.valid? && @version.valid?
      @page.versions << @version
      @page.save
      redirect url(:page, @page)
    else
      render :new
    end
  end

  # Accessed by: PUT /pages/1
  def update(id, version)
    @page = Page.by_slug(id) || raise(NotFound)
    @page.versions << @version = Version.new(version.merge(:user => @user))
    if @version.save
      redirect url(:page, @page)
    else
      render :edit
    end
  end
end