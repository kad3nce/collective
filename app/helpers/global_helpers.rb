module Merb
  module GlobalHelpers
    def account_and_logout_button
      <<-BUTTON
      <div id='logout'>
        <form method="post" action="#{url(:logout)}">
          Logged in as #{@user.name} |
          <input type="hidden" value="delete" name="_method"/>
          <button type="submit">Logout</button>
        </form>
      </div>
      BUTTON
      # <<-BUTTON
      # <div id='logout'>
      #   <form method="post" action="#{url(:logout)}">
      #     Logged in as #{link_to(@user.name, url(:user, @user.id))} |
      #     <input type="hidden" value="delete" name="_method"/>
      #     <button type="submit">Logout</button>
      #   </form>
      # </div>
      # BUTTON
    end
    
    def login_or_name
      @user.name == 'Anonymous' ? "Anonymous (#{link_to_login})" : @user.name
    end
    
    def highlighted_link_to(title, url)
      opts = {}
      opts.merge!(:id => 'active') if @page_title && @page_title == title
      link_to(title, url, opts)
    end

    def link_to_login
      link_to 'Login', url(:new_session, :destination => request.path)
    end

    def link_to_login_or_account
      if @user.name == 'Anonymous'
        link_to_login
      else
        account_and_logout_button
      end
    end
    
    def title(options)
      if(options.is_a?(Hash))
        merged_title = @site_title = options[:site].dup
        (merged_title << " | #{@page_title}") if @page_title
        return merged_title
      else
        @page_title = options
        return @page_title
      end
    end
  end
end
