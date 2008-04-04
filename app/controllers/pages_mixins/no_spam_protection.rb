module NoSpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  def create(page)
    @page = Page.new page
    if @page.save
      redirect url(:page, @page)
    else
      render :new
    end
  end

  def update(id, page)
    @page = Page.first(:slug => id) || raise(NotFound)
    if @page.update_attributes(:content => page[:content])
      redirect url(:page, @page)
    else
      raise BadRequest
    end
  end
end