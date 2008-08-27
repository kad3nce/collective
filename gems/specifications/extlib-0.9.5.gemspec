Gem::Specification.new do |s|
  s.name = %q{extlib}
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Smoot"]
  s.date = %q{2008-08-25}
  s.description = %q{Support library for DataMapper and Merb.}
  s.email = %q{ssmoot@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.txt"]
  s.files = ["LICENSE", "README.txt", "Rakefile", "lib/extlib", "lib/extlib/assertions.rb", "lib/extlib/blank.rb", "lib/extlib/class.rb", "lib/extlib/hash.rb", "lib/extlib/hook.rb", "lib/extlib/inflection.rb", "lib/extlib/lazy_array.rb", "lib/extlib/logger.rb", "lib/extlib/mash.rb", "lib/extlib/module.rb", "lib/extlib/object.rb", "lib/extlib/object_space.rb", "lib/extlib/pathname.rb", "lib/extlib/pooling.rb", "lib/extlib/rubygems.rb", "lib/extlib/simple_set.rb", "lib/extlib/string.rb", "lib/extlib/struct.rb", "lib/extlib/tasks", "lib/extlib/tasks/release.rb", "lib/extlib/time.rb", "lib/extlib/version.rb", "lib/extlib/virtual_file.rb", "lib/extlib.rb"]
  s.homepage = %q{http://extlib.rubyforge.org}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Support library for DataMapper and Merb.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<english>, [">= 0.2.0"])
    else
      s.add_dependency(%q<english>, [">= 0.2.0"])
    end
  else
    s.add_dependency(%q<english>, [">= 0.2.0"])
  end
end
