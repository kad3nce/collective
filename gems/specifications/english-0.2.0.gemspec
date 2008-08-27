Gem::Specification.new do |s|
  s.name = %q{english}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Trans <transfire @ gmail.com>"]
  s.date = %q{2008-02-05}
  s.description = %q{English is a English grammer and general language processing library. It include a number of usefule tools, such as Inflect.}
  s.email = %q{transfire @ gmail.com}
  s.files = ["test", "test/test_levenshtein.rb", "test/test_similarity.rb", "test/test_soundex.rb", "test/test_inflect.rb", "test/test_double_metaphone.rb", "test/test_porter_stemming.rb", "test/test_censor.rb", "test/fixture", "test/fixture/soundex.txt", "test/fixture/metaphone.txt", "test/fixture/double_metaphone.txt", "test/fixture/porter_stemming_input.txt", "test/fixture/metaphone_lp.txt", "test/fixture/porter_stemming_output.txt", "test/test_dresner.rb", "test/test_metaphone.rb", "NOTES", "CHANGES", "README", "meta", "meta/MANIFEST", "meta/project.yaml", "meta/version", "meta/dependencies", "meta/description", "task", "task/test", "task/rdoc", "task/setup", "task/clobber", "lib", "lib/english", "lib/english/double_metaphone.rb", "lib/english/censor.rb", "lib/english/porter_stemming.rb", "lib/english/levenshtein.rb", "lib/english/dresner.rb", "lib/english/jumble.rb", "lib/english/soundex.rb", "lib/english/metaphone.rb", "lib/english/textfilter.rb", "lib/english/similarity.rb", "lib/english/inflect.rb", "lib/english/roman.rb", "lib/english/numerals.rb", "lib/english/patterns.rb", "log", "log/Changelog.txt", "log/Testlog.txt", "COPYING"]
  s.has_rdoc = true
  s.homepage = %q{http://english.rubyforge.org}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{orphans}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{English Code Kit}
  s.test_files = ["test/test_levenshtein.rb", "test/test_similarity.rb", "test/test_soundex.rb", "test/test_inflect.rb", "test/test_double_metaphone.rb", "test/test_porter_stemming.rb", "test/test_censor.rb", "test/fixture", "test/fixture/soundex.txt", "test/fixture/metaphone.txt", "test/fixture/double_metaphone.txt", "test/fixture/porter_stemming_input.txt", "test/fixture/metaphone_lp.txt", "test/fixture/porter_stemming_output.txt", "test/test_dresner.rb", "test/test_metaphone.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<facets>, [">= 2.2.0"])
    else
      s.add_dependency(%q<facets>, [">= 2.2.0"])
    end
  else
    s.add_dependency(%q<facets>, [">= 2.2.0"])
  end
end
