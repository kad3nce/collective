Gem::Specification.new do |s|
  s.name = %q{merb_openid}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Webb"]
  s.autorequire = %q{merb_openid}
  s.date = %q{2008-06-13}
  s.description = %q{A Merb plugin for consuming OpenID}
  s.email = %q{dan@danwebb.net}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["LICENSE", "README", "Rakefile", "lib/merb_openid.rb", "lib/merb_openid/controller_extensions.rb", "spec/merb_openid_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A Merb plugin for consuming OpenID}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.0"])
      s.add_runtime_dependency(%q<ruby-openid>, [">= 2.0.3"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.0"])
      s.add_dependency(%q<ruby-openid>, [">= 2.0.3"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.0"])
    s.add_dependency(%q<ruby-openid>, [">= 2.0.3"])
  end
end
