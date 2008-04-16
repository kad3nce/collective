module SpamProtection
  def self.included(base)
    base.show_action(:create, :update)
  end
  
  def create
    @page = Page.new(params[:page])
    @page.remote_ip = request.remote_ip
    if @page.valid?
      flash[:notice] = 'Your new page will appear momentarily.'
      redirect_then_call(url(:pages)) do
        response = check_comment_with_spam_engine(@page)
        if response[:spam]
          Version.create_spam(@page.name, 
            :content   => @page.content, 
            :spaminess => response[:spaminess], 
            :signature => response[:signature], 
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
    unless params[:page][:content].strip.blank?
      flash[:notice] = 'Your changes will appear momentarily.'
      redirect_then_call(url(:page, @page)) do
        response = check_comment_with_spam_engine(@page, params[:page][:content])        
        @page.update_attributes(
          params[:page].update(
            :signature => response[:signature], 
            :spaminess => response[:spaminess], 
            :remote_ip => request.remote_ip
          )
        )
      end
    else
      flash[:notice] = "Your changes have been rejected"
      render :edit
    end
  end
  
private

  def check_comment_with_spam_engine(page, content=nil)
    Viking.check_comment(
      default_spam_engine_params.update(
        :comment_content => content_as_html(page, content),
        :user_ip         => request.remote_ip,
        :permalink       => permalink_for_page(page.slug)
      )
    )
  end

  def content_as_html(page, content)
    content = page.new_record? ? page.content : page.content_diff(content)
    RedCloth.new(content).to_html
  end

  def permalink_for_page(slug)
    "http://#{Viking.default_instance.options[:blog]}/pages/#{slug}"
  end

  def default_spam_engine_params(page_slug)
    { 
      :comment_author => 'anonymous', 
      :comment_type   => 'comment', 
      :article_date   => Time.now.defensio_date_format, 
      :user_logged_in => false,
      :trusted_user   => false
    }
  end
end