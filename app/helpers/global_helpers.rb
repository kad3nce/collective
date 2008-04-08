module Merb
  module GlobalHelpers
    def highlighted_link_to(title, url)
      opts = {}
      opts.merge!(:id => 'active') if @page_title && @page_title == title
      link_to(title, url, opts)
    end
    
    def title(options)
      if(options.is_a?(Hash))
        merged_title = @site_title = options[:site]
        (merged_title << " | #{@page_title}") if @page_title
        return merged_title
      else
        @page_title = options
        return @page_title
      end
    end
  end
end
