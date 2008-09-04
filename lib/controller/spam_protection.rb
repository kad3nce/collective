module SpamProtection
  def self.included(base)
    base.show_action(:create, :update)
    # Merb::Config[:deferred_actions] = ['/heavy/lifting']
  end

  # Accessed by: POST /pages
  def create(page, version)
    @page = Page.new(page)
    @page.versions << @version = Version.new(version.merge!(:remote_ip => request.remote_ip, :user => @user))
    if @page.valid? && @version.valid?
      response = check_comment_with_spam_engine(@page.url, @version.content_html)
      if response[:spam]
        Version.create_spam(@page.name,
          :content   => @version.content,
          :spaminess => response[:spaminess],
          :signature => response[:signature],
          :remote_ip => @version.remote_ip
        )
      else
        @version.signature = response[:signature]
        @version.spaminess = response[:spaminess]
        @page.save
      end
      redirect url(:pages)
    else
      render :new
    end
  end

  # Accessed by: PUT /pages/1
  def update(id, version)
    @page = Page.by_slug(id) || raise(Merb::ControllerExceptions::NotFound)
    @page.versions << @version = Version.new(version.merge!(:remote_ip => request.remote_ip, :user => @user))
    if @version.valid?
      response = check_comment_with_spam_engine(@page.url, @version.additions(@page.versions))
      @version.signature = response[:signature]
      @version.spam      = response[:spam]
      @version.spaminess = response[:spaminess]
      @version.save
      redirect url(:page, @page)
    else
      render :edit
    end
  end
  
private

  def check_comment_with_spam_engine(url, content)
    Viking.check_comment(
      :article_date    => Time.now,
      :comment_author  => @user.name,
      :comment_content => content,
      :comment_type    => 'other',
      :openid          => @user.openid_url,
      :permalink       => url,
      :trusted_user    => @user.trusted?,
      :user_ip         => request.remote_ip,
      :user_logged_in  => true
    )
  end
  
end