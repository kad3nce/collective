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
        "Mark as #{version.spam_or_ham == 'spam' ? 'Ham' : 'Spam'}", 
        "</button>"
      ].join("")
    end

    def view_diff(diff)
      render  = ""
      render_add = ""
      render_del = ""
      unless diff.nil?
        diff.split("\n").each do |line|
          next if line.empty?

          if line =~ /^@@ -(\d+),*\d* \+(\d+),*\d* @@/
            render += fill_render_add(render_add)
            render += fill_render_del(render_del)
            render += fill_type_diff(Regexp.last_match(1))
            render_add = ""
            render_del = ""
            next
          end

          if line =~ /^\+(.*)/
            render_add += "#{Regexp.last_match(1)} \n"
            next
          end
          
          if line =~ /^-(.*)/
            render_del += "#{Regexp.last_match(1)} \n"
            next
          end
        end
        render += fill_render_add(render_add)
        render += fill_render_del(render_del)
      end
      render
    end

  private
    def fill_render_add(value)
      unless value.empty?
        "<div class=\"addition\">#{preserve(value)}</div>"
      else
        ""
      end
    end

    def fill_render_del(value)
      unless value.empty?
        "<div class=\"deletion\">#{preserve(value)}</div>"
      else
        ""
      end
    end

    def fill_type_diff(line_number)
      "<h4>Edited line #{line_number} :</h4>"
    end

  end
end
