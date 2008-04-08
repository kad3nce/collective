Gem::Specification.new do |s|
  s.name = %q{merb_has_flash}
  s.version = "0.9.2"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Ivey"]
  s.autorequire = %q{merb_has_flash}
  s.date = %q{2008-03-26}
  s.description = %q{Merb plugin that provides a Rails-style flash}
  s.email = %q{ivey@gweezlebur.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb_has_flash", "lib/merb_has_flash/controller_extension.rb", "lib/merb_has_flash/flash_hash.rb", "lib/merb_has_flash/helper.rb", "lib/merb_has_flash.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merb-plugins.rubyforge.org/merb_has_flash/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.0}
  s.summary = %q{Merb plugin that provides a Rails-style flash}

  s.add_dependency(%q<merb-core>, [">= 0.9.2"])
end
