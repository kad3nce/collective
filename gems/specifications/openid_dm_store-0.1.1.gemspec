Gem::Specification.new do |s|
  s.name = %q{openid_dm_store}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jed Hurt"]
  s.date = %q{2008-06-17}
  s.description = %q{Adds a DataMapper store to ruby-openid}
  s.email = %q{jed.hurt@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["LICENSE", "README", "openid_dm_store.rb", "lib/association.rb", "lib/nonce.rb", "lib/openid_dm_store.rb"]
  s.has_rdoc = %q{true}
  s.homepage = %q{http://github.com/meekish/openid_dm_store}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.4")
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Adds a DataMapper store to ruby-openid}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<ruby-openid>, [">= 0"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
    else
      s.add_dependency(%q<ruby-openid>, [">= 0"])
      s.add_dependency(%q<dm-core>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruby-openid>, [">= 0"])
    s.add_dependency(%q<dm-core>, [">= 0"])
  end
end
