module Merb
  module PagesHelper

    def select_versions_for_page(page, version)
      versions = (1..page.versions.length).map { |number| [number,number] }
      versions.last[1] = 'Latest'
      open_tag('select', {:name => 'version', :id => 'version-select'}) +
        options_for_select(versions.reverse, :selected => page.versions.index(version)+1) +
        "</select>"
    end

  end
end
