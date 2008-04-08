require 'diff/lcs'
require 'viking/viking'
require 'viking/defensio'
DEFENSIO_GATEWAY = Viking::Defensio.new(YAML.load(File.read(Merb.root / 'config' / 'defensio.yml'))[:defensio])
DEFENSIO_REQUIRED_PARAMS = { :comment_author => 'anonymous', :comment_type => 'comment' }

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
        response = DEFENSIO_GATEWAY.check_comment(DEFENSIO_REQUIRED_PARAMS.merge(
          :article_date => Time::now.strftime('%Y/%m/%d'),
          :comment_content => content_as_html,
          :user_ip => request.remote_ip,
          :permalink => "http://#{DEFENSIO_GATEWAY.options[:blog]}/pages/#{@page.slug}",
          :user_logged_in => false,
          :trusted_user => false
        ))
        if (response[:spam])
          Version.create(:content => "#{@page.content}:#{@page.name}", :spam => true, :spaminess => response[:spaminess], :signature => response[:signature], :page_id => -1, :remote_ip => request.remote_ip)
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
        response = DEFENSIO_GATEWAY.check_comment(DEFENSIO_REQUIRED_PARAMS.merge(
          :article_date => Time::now.strftime('%Y/%m/%d'),
          :comment_content => new_content_as_html,
          :user_ip => request.remote_ip,
          :permalink => "http://#{DEFENSIO_GATEWAY.options[:blog]}/pages/#{@page.slug}",
          :user_logged_in => false,
          :trusted_user => false
        ))
        page_attributes.merge!(:signature => response[:signature], :spaminess => response[:spaminess])
        if (response[:spam])
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