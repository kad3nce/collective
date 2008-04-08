Gem::Specification.new do |s|
  s.name = %q{merb_http_basic_auth}
  s.version = "0.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonas Nicklas"]
  s.autorequire = %q{merb_http_basic_auth}
  s.date = %q{2008-04-08}
  s.description = %q{Merb plugin that provides HTTP basic authentication}
  s.email = %q{jonas.nicklas@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb_http_basic_auth.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merb-plugins.rubyforge.org/http_basic_auth/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.0}
  s.summary = %q{Merb plugin that provides HTTP basic authentication}

  s.add_dependency(%q<merb-core>, [">= 0.9.2"])
end
