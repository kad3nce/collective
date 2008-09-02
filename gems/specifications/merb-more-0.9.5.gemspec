Gem::Specification.new do |s|
  s.name = %q{merb-more}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ezra Zygmuntowicz"]
  s.date = %q{2008-08-25}
  s.description = %q{(merb - merb-core) == merb-more.  The Full Stack. Take what you need; leave what you don't.}
  s.email = %q{ez@engineyard.com}
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb-more.rb"]
  s.homepage = %q{http://www.merbivore.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{(merb - merb-core) == merb-more.  The Full Stack. Take what you need; leave what you don't.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.5"])
      s.add_runtime_dependency(%q<merb-action-args>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-assets>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-gen>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-haml>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-builder>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-mailer>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-parts>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-cache>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-freezer>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-slices>, [">= 0.9.5", "<= 1.0"])
      s.add_runtime_dependency(%q<merb-jquery>, [">= 0.9.5", "<= 1.0"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.5"])
      s.add_dependency(%q<merb-action-args>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-assets>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-gen>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-haml>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-builder>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-mailer>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-parts>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-cache>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-freezer>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-slices>, [">= 0.9.5", "<= 1.0"])
      s.add_dependency(%q<merb-jquery>, [">= 0.9.5", "<= 1.0"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.5"])
    s.add_dependency(%q<merb-action-args>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-assets>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-gen>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-haml>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-builder>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-mailer>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-parts>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-cache>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-freezer>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-slices>, [">= 0.9.5", "<= 1.0"])
    s.add_dependency(%q<merb-jquery>, [">= 0.9.5", "<= 1.0"])
  end
end
