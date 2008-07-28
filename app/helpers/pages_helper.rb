module Merb
  module PagesHelper

    def select_versions_for_page(page, version, attrs)
      versions = (1 ... page.versions_count).map { |v| [v,v] }
      versions << [page.versions_count, 'Latest']
      open_tag('select', attrs) +
        options_for_select(versions.reverse, :selected => version.number) +
        "</select>"
    end

  end
end
