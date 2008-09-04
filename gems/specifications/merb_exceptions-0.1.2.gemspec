Gem::Specification.new do |s|
  s.name = %q{merb_exceptions}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Kent"]
  s.autorequire = %q{merb_exceptions}
  s.date = %q{2008-09-04}
  s.description = %q{Allows Merb to forward exceptions to emails or web hooks}
  s.email = %q{andy@new-bamboo.co.uk}
  s.extra_rdoc_files = ["LICENSE", "TODO"]
  s.files = ["LICENSE", "README.markdown", "Rakefile", "TODO", "lib/merb_exceptions", "lib/merb_exceptions/controller_extensions.rb", "lib/merb_exceptions/notification.rb", "lib/merb_exceptions/templates", "lib/merb_exceptions/templates/email.erb", "lib/merb_exceptions/version.rb", "lib/merb_exceptions.rb", "spec/spec_helper.rb", "spec/unit", "spec/unit/notification_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://merb-plugins.rubyforge.org/me/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Allows Merb to forward exceptions to emails or web hooks}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
