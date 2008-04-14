module Merb
  module EditsHelper
    #--
    # FIXME This method explodes if Version is nil, or Version does not have 
    # any contents
    def link_to_page_or_nothing(version)
      if(page = version.page)
        link_to page.name, url(:page, page)
      else
        "New Page: #{version.content.split(':').last}"
      end
    end
    
    def mark_as_ham_or_spam(version)
      [
        open_tag('button', :type => 'submit'), 
        "This is #{version.spam_or_ham.capitalize}", 
        "</button>"
      ].join("")
    end
  end
end