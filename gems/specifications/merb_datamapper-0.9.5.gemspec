Gem::Specification.new do |s|
  s.name = %q{merb_datamapper}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Toy"]
  s.date = %q{2008-08-25}
  s.description = %q{DataMapper plugin providing DataMapper support for Merb}
  s.email = ["jtoy@rubynow.com"]
  s.extra_rdoc_files = ["README.txt", "LICENSE", "TODO"]
  s.files = ["History.txt", "LICENSE", "Manifest.txt", "README.txt", "Rakefile", "TODO", "lib/generators/data_mapper_migration.rb", "lib/generators/data_mapper_model.rb", "lib/generators/data_mapper_resource_controller.rb", "lib/generators/templates/migration.rb", "lib/generators/templates/model.rb", "lib/generators/templates/model_migration.rb", "lib/generators/templates/resource_controller.rb", "lib/generators/templates/views/edit.html.erb", "lib/generators/templates/views/index.html.erb", "lib/generators/templates/views/new.html.erb", "lib/generators/templates/views/show.html.erb", "lib/merb/orms/data_mapper/connection.rb", "lib/merb/orms/data_mapper/database.yml.sample", "lib/merb/orms/data_mapper/resource.rb", "lib/merb/session/data_mapper_session.rb", "lib/merb_datamapper.rb", "lib/merb_datamapper/merbtasks.rb", "lib/merb_datamapper/version.rb", "spec/connection_spec.rb", "spec/generators/data_mapper_migration_spec.rb", "spec/generators/data_mapper_model_spec.rb", "spec/generators/data_mapper_resource_controller_spec.rb", "spec/generators/spec_helper.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/sam/dm-more/tree/master/merb_datamapper}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{DataMapper plugin providing DataMapper support for Merb}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<dm-core>, ["= 0.9.5"])
      s.add_runtime_dependency(%q<dm-migrations>, ["= 0.9.5"])
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.4"])
      s.add_runtime_dependency(%q<templater>, [">= 0.1.5"])
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<dm-core>, ["= 0.9.5"])
      s.add_dependency(%q<dm-migrations>, ["= 0.9.5"])
      s.add_dependency(%q<merb-core>, [">= 0.9.4"])
      s.add_dependency(%q<templater>, [">= 0.1.5"])
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<dm-core>, ["= 0.9.5"])
    s.add_dependency(%q<dm-migrations>, ["= 0.9.5"])
    s.add_dependency(%q<merb-core>, [">= 0.9.4"])
    s.add_dependency(%q<templater>, [">= 0.1.5"])
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
