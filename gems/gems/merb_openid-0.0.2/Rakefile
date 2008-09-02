require 'rubygems'
require 'rake/gempackagetask'

spec = eval(File.read(File.join(File.dirname(__FILE__), 'merb_openid.gemspec')))

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

task :install => [:package] do
  sh %{sudo gem install pkg/#{spec.name}-#{spec.version} --no-update-sources}
end

namespace :jruby do

  desc "Run :package and install the resulting .gem with jruby"
  task :install => :package do
    sh %{#{SUDO} jruby -S gem install pkg/#{spec.name}-#{Merb::VERSION}.gem --no-rdoc --no-ri}
  end
  
end