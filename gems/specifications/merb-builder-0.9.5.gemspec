Gem::Specification.new do |s|
  s.name = %q{merb-builder}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Younger"]
  s.date = %q{2008-08-20}
  s.description = %q{Merb plugin that provides Builder support}
  s.email = %q{jonathan@daikini.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb-builder", "lib/merb-builder/template.rb", "lib/merb-builder.rb", "spec/builder_spec.rb", "spec/controllers", "spec/controllers/builder.rb", "spec/controllers/views", "spec/controllers/views/builder_config", "spec/controllers/views/builder_config/index.xml.builder", "spec/controllers/views/builder_controller", "spec/controllers/views/builder_controller/index.xml.builder", "spec/controllers/views/capture_builder", "spec/controllers/views/capture_builder/index.xml.builder", "spec/controllers/views/concat_builder", "spec/controllers/views/concat_builder/index.xml.builder", "spec/controllers/views/partial_builder", "spec/controllers/views/partial_builder/_partial_builder.xml.builder", "spec/controllers/views/partial_builder/index.xml.builder", "spec/controllers/views/partial_ivars", "spec/controllers/views/partial_ivars/_partial_builder.xml.builder", "spec/controllers/views/partial_ivars/index.xml.builder", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merbivore.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Merb plugin that provides Builder support}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.5"])
      s.add_runtime_dependency(%q<builder>, [">= 2.0.0"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.5"])
      s.add_dependency(%q<builder>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.5"])
    s.add_dependency(%q<builder>, [">= 2.0.0"])
  end
end
