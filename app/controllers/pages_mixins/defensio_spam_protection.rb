require 'diff/lcs'
module DefensioSpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  def create
    @page = Page.new(params[:page].merge(:remote_ip => request.remote_ip))
    if @page.valid?
      flash[:notice] = 'Your new page will appear momentarily.'
      redirect_then_call(url(:pages)) do
        content_as_html = RedCloth.new(@page.content).to_html
        response = {} # send content_as_html to Defensio API to check for spaminess
        if (response[:spam]) # defensio says it's spam
          Version.create(:content => @page.content, :spam => true, :spaminess => response[:spaminess], :signature => response[:signature], :page_id => -1, :remote_ip => request.remote_ip)
        else
          @page.signature = response[:signature]
          @page.spaminess = response[:spaminess]
          @page.save
        end
      end
    else
      render :new
    end
  end

  def update
    @page = Page.by_slug(params[:id]) || raise(NotFound)
    page_attributes = { :content => params[:page][:content], :remote_ip => request.remote_ip }
    unless page_attributes[:content].strip.blank?
      flash[:notice] = 'Your changes will appear momentarily.'
      redirect_then_call(url(:page, @page)) do
        new_content_as_html = RedCloth.new(@page.content_additions(params[:page][:content])).to_html
        response = {} # send new_content_as_html to Defensio API to check for spaminess
        page_attributes.merge!(:signature => response[:signature], :spaminess => response[:spaminess])
        if (response[:spam]) # Defensio says it's spam
          @page.update_attributes(page_attributes.merge(:spam => true))
        else
          @page.update_attributes(page_attributes)
        end
      end
    else
      @page.errors.add(:content, 'cannot be blank.')
      render :edit
    end
  end
  
end