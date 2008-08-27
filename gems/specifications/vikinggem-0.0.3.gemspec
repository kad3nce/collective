Gem::Specification.new do |s|
  s.name = %q{vikinggem}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Herdman"]
  s.date = %q{2008-04-24}
  s.description = %q{Gemified version of the Viking plugin}
  s.email = ["james.herdman@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "Readme.txt", "website/index.txt"]
  s.files = [".autotest", "History.txt", "Manifest.txt", "Rakefile", "Readme.txt", "lib/core_ext/object.rb", "lib/core_ext/transformations.rb", "lib/viking.rb", "lib/viking/akismet.rb", "lib/viking/base.rb", "lib/viking/defensio.rb", "lib/viking/version.rb", "lib/viking/viking.rb", "setup.rb", "spec/core_ext/object_spec.rb", "spec/core_ext/transformations_spec.rb", "spec/lib/akismet_sepc.rb", "spec/lib/base_sepc.rb", "spec/lib/defensio_spec.rb", "spec/lib/viking_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake", "tasks/website.rake", "website/index.html", "website/index.txt", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://vikinggem.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{vikinggem}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Gemified version of the Viking plugin}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
