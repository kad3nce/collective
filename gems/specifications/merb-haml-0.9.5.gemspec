Gem::Specification.new do |s|
  s.name = %q{merb-haml}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yehuda Katz"]
  s.date = %q{2008-08-20}
  s.description = %q{Merb plugin that provides HAML support}
  s.email = %q{ykatz@engineyard.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/generators", "lib/generators/controller.rb", "lib/generators/layout.rb", "lib/generators/resource_controller.rb", "lib/generators/templates", "lib/generators/templates/controller", "lib/generators/templates/controller/app", "lib/generators/templates/controller/app/views", "lib/generators/templates/controller/app/views/%file_name%", "lib/generators/templates/controller/app/views/%file_name%/index.html.haml", "lib/generators/templates/layout", "lib/generators/templates/layout/app", "lib/generators/templates/layout/app/views", "lib/generators/templates/layout/app/views/layout", "lib/generators/templates/layout/app/views/layout/%file_name%.html.haml", "lib/generators/templates/resource_controller", "lib/generators/templates/resource_controller/activerecord", "lib/generators/templates/resource_controller/activerecord/app", "lib/generators/templates/resource_controller/activerecord/app/views", "lib/generators/templates/resource_controller/activerecord/app/views/%file_name%", "lib/generators/templates/resource_controller/activerecord/app/views/%file_name%/edit.html.haml", "lib/generators/templates/resource_controller/activerecord/app/views/%file_name%/index.html.haml", "lib/generators/templates/resource_controller/activerecord/app/views/%file_name%/new.html.haml", "lib/generators/templates/resource_controller/activerecord/app/views/%file_name%/show.html.haml", "lib/generators/templates/resource_controller/datamapper", "lib/generators/templates/resource_controller/datamapper/app", "lib/generators/templates/resource_controller/datamapper/app/views", "lib/generators/templates/resource_controller/datamapper/app/views/%file_name%", "lib/generators/templates/resource_controller/datamapper/app/views/%file_name%/edit.html.haml", "lib/generators/templates/resource_controller/datamapper/app/views/%file_name%/index.html.haml", "lib/generators/templates/resource_controller/datamapper/app/views/%file_name%/new.html.haml", "lib/generators/templates/resource_controller/datamapper/app/views/%file_name%/show.html.haml", "lib/generators/templates/resource_controller/none", "lib/generators/templates/resource_controller/none/app", "lib/generators/templates/resource_controller/none/app/views", "lib/generators/templates/resource_controller/none/app/views/%file_name%", "lib/generators/templates/resource_controller/none/app/views/%file_name%/edit.html.haml", "lib/generators/templates/resource_controller/none/app/views/%file_name%/index.html.haml", "lib/generators/templates/resource_controller/none/app/views/%file_name%/new.html.haml", "lib/generators/templates/resource_controller/none/app/views/%file_name%/show.html.haml", "lib/generators/templates/resource_controller/sequel", "lib/generators/templates/resource_controller/sequel/app", "lib/generators/templates/resource_controller/sequel/app/views", "lib/generators/templates/resource_controller/sequel/app/views/%file_name%", "lib/generators/templates/resource_controller/sequel/app/views/%file_name%/edit.html.haml", "lib/generators/templates/resource_controller/sequel/app/views/%file_name%/index.html.haml", "lib/generators/templates/resource_controller/sequel/app/views/%file_name%/new.html.haml", "lib/generators/templates/resource_controller/sequel/app/views/%file_name%/show.html.haml", "lib/merb-haml", "lib/merb-haml/merbtasks.rb", "lib/merb-haml/template.rb", "lib/merb-haml.rb", "spec/controllers", "spec/controllers/haml.rb", "spec/controllers/views", "spec/controllers/views/capture_haml", "spec/controllers/views/capture_haml/index.html.haml", "spec/controllers/views/concat_haml", "spec/controllers/views/concat_haml/index.html.haml", "spec/controllers/views/haml_config", "spec/controllers/views/haml_config/index.html.haml", "spec/controllers/views/haml_controller", "spec/controllers/views/haml_controller/index.html.haml", "spec/controllers/views/partial_haml", "spec/controllers/views/partial_haml/_partial_haml.html.haml", "spec/controllers/views/partial_haml/index.html.haml", "spec/controllers/views/partial_ivars", "spec/controllers/views/partial_ivars/_partial_haml.html.haml", "spec/controllers/views/partial_ivars/index.html.haml", "spec/haml_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merbivore.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Merb plugin that provides HAML support}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.5"])
      s.add_runtime_dependency(%q<haml>, [">= 1.8.2"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.5"])
      s.add_dependency(%q<haml>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.5"])
    s.add_dependency(%q<haml>, [">= 1.8.2"])
  end
end
