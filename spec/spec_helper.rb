require 'rubygems'
# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'gems')))
require 'merb-core'
require 'spec' # Satiates Autotest and anyone else not using the Rake tasks

Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')

require File.join(File.dirname(__FILE__), 'spec_fixtures')

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
end

# Load helpers for specs
Dir[File.dirname(__FILE__) / "shared" / "*.rb"].each do |helper|
  require(helper)
end

require 'bootstrapper'
Bootstrapper.bootstrap!
