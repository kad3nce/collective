# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# Make the app's "lib" directory a place where ruby files get "require"d from
$LOAD_PATH.unshift(Merb.root / "lib")

Merb::Config.use do |c|
  c[:session_secret_key]  = '56640eca0bd537b75c2366fd22e6744072cd7891'
  c[:session_store] = 'cookie'
end  

### Merb doesn't come with database support by default.  You need
### an ORM plugin.  Install one, and uncomment one of the following lines,
### if you need a database.

use_orm :datamapper

### This defines which test framework the generators will use
### rspec is turned on by default

use_test :rspec

### Add your other dependencies here

dependencies 'iconv', 'merb-action-args', 'merb-assets', 'merb_has_flash', 
             'merb-haml', 'merb_helpers', 'merb_http_basic_auth', 'RedCloth', 
             'uri'

# dependency "RedCloth", "> 3.0"
# OR
# dependencies "RedCloth" => "> 3.0", "ruby-aes-cext" => "= 1.0"

Dir[Merb.root / 'app' / 'controllers' / 'page_mixins' / '*.rb'].each do |mixin|
  require mixin
end

Merb::BootLoader.after_app_loads do
  if Merb.environment == 'development'
    # Merb.logger.info('Auto migrating development database')
    # DataMapper::Persistence.auto_migrate! 
    require Merb.root / 'db' / 'seed_dev' unless Page.count > 0
  end
  
  require Merb.root / 'lib' / 'core_ext' / 'try'
  require Merb.root / 'lib' / 'controller' / 'mixins' / 'controller'
end
