Gem::Specification.new do |s|
  s.name = %q{addressable}
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bob Aman"]
  s.date = %q{2008-05-02}
  s.description = %q{Addressable is a replacement for the URI implementation that is part of Ruby's standard library. It more closely conforms to the relevant RFCs and adds support for IRIs and URI templates.}
  s.email = %q{bob@sporkmonger.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["lib/addressable", "lib/addressable/uri.rb", "lib/addressable/version.rb", "spec/addressable", "spec/addressable/uri_spec.rb", "spec/data", "spec/data/rfc3986.txt", "coverage/-Library-Ruby-Gems-1_8-gems-rcov-0_8_1_2_0-lib-rcov_rb.html", "coverage/-Library-Ruby-Gems-1_8-gems-rspec-1_1_3-bin-spec.html", "coverage/-Library-Ruby-Gems-1_8-gems-rspec-1_1_3-lib-spec_rb.html", "coverage/-Library-Ruby-Gems-1_8-gems-rspec-1_1_3-plugins-mock_frameworks-rspec_rb.html", "coverage/index.html", "coverage/lib-addressable-uri_rb.html", "coverage/lib-addressable-version_rb.html", "CHANGELOG", "LICENSE", "README", "rakefile"]
  s.has_rdoc = true
  s.homepage = %q{http://sporkmonger.com/}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{addressable}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{URI Implementation}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<rake>, [">= 0.7.3"])
      s.add_runtime_dependency(%q<rspec>, [">= 1.0.8"])
    else
      s.add_dependency(%q<rake>, [">= 0.7.3"])
      s.add_dependency(%q<rspec>, [">= 1.0.8"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.7.3"])
    s.add_dependency(%q<rspec>, [">= 1.0.8"])
  end
end
