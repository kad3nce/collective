require 'diff/lcs'

module SpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  def create
    @page = Page.new(params[:page].merge(:remote_ip => request.remote_ip))
    if @page.valid?
      flash[:notice] = 'Your new page will appear momentarily.'
      redirect_then_call(url(:pages)) do
        response = check_comment(@page)
        if response[:spam]
          Version.create(
            :content   => "#{@page.content}:#{@page.name}", 
            :spam      => true, 
            :spaminess => response[:spaminess], 
            :signature => response[:signature], 
            :page_id   => -1, 
            :remote_ip => request.remote_ip
          )
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
        response = check_comment(@page, params[:page][:content])
        
        page_attributes.merge!(
          :signature => response[:signature], 
          :spaminess => response[:spaminess]
        )
        
        if response[:spam]
          @page.update_attributes(page_attributes.merge(:spam => true))
        else
          @page.update_attributes(page_attributes)
        end
      end
    else
      @page.errors.add :content, 'cannot be blank'
      render :edit
    end
  end
  
private

  def check_comment_with_defensio(page, content=nil)
    Viking.check_comment(
      default_defensio_params.update(
        :comment_content => content_as_html(page, content),
        :user_ip         => request.remote_ip,
        :permalink       => permalink_for_page(page.slug)
      )
    )
  end

  def content_as_html(page, content)
    content = page.new_record? ? page.content : page.content_additions(content)
    RedCloth.new(content).to_html
  end

  def permalink_for_page(slug)
    "http://#{Viking.default_instance.options[:blog]}/pages/#{slug}"
  end

  def default_defensio_params(page_slug)
    { 
      :comment_author => 'anonymous', 
      :comment_type   => 'comment', 
      :article_date   => Time.now.defensio_date_format, 
      :user_logged_in => false,
      :trusted_user   => false
    }
  end
  
end