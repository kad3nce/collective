Gem::Specification.new do |s|
  s.name = %q{tlsmail}
  s.version = "0.0.1"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["zorio"]
  s.cert_chain = nil
  s.date = %q{2007-03-17}
  s.description = %q{This library enables pop or smtp via ssl/tls by dynamically replacing these classes to these in ruby 1.9.}
  s.email = %q{zoriorz@gmail.com}
  s.files = ["Rakefile", "README.txt", "CHANGELOG.txt", "Manifest.txt", "lib/tlsmail.rb", "lib/net/pop.rb", "lib/net/smtp.rb", "test/test_helper.rb", "test/tlsmail_test.rb", "test/template.parameters.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://tlsmail.rubyforge.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{tlsmail}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{This library enables pop or smtp via ssl/tls by dynamically replacing these classes to these in ruby 1.9.}
  s.test_files = ["test/tlsmail_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if current_version >= 3 then
    else
    end
  else
  end
end
