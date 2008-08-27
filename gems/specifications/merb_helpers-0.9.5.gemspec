Gem::Specification.new do |s|
  s.name = %q{merb_helpers}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yehuda Katz"]
  s.date = %q{2008-08-25}
  s.description = %q{Helper support for merb (similar to the Rails form helpers)}
  s.email = %q{ykatz@engineyard.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb_helpers", "lib/merb_helpers/core_ext.rb", "lib/merb_helpers/date_time_helpers.rb", "lib/merb_helpers/form", "lib/merb_helpers/form/builder.rb", "lib/merb_helpers/form/helpers.rb", "lib/merb_helpers/form_helpers.rb", "lib/merb_helpers/ordinalize.rb", "lib/merb_helpers/tag_helpers.rb", "lib/merb_helpers/time_dsl.rb", "lib/merb_helpers.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merbivore.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Helper support for merb (similar to the Rails form helpers)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.5"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.5"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.5"])
  end
end
