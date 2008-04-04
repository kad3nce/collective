# Make the app's "gems" directory a place where gems are loaded from
Gem.clear_paths
Gem.path.unshift(Merb.root / "gems")

# Make the app's "lib" directory a place where ruby files get "require"d from
$LOAD_PATH.unshift(Merb.root / "lib")


Merb::Config.use do |c|
  
  ### Sets up a custom session id key, if you want to piggyback sessions of other applications
  ### with the cookie session store. If not specified, defaults to '_session_id'.
  # c[:session_id_key] = '_session_id'
  
  c[:session_secret_key]  = '56640eca0bd537b75c2366fd22e6744072cd7891'
  c[:session_store] = 'cookie'
end  

### Merb doesn't come with database support by default.  You need
### an ORM plugin.  Install one, and uncomment one of the following lines,
### if you need a database.

### Uncomment for DataMapper ORM
use_orm :datamapper

### Uncomment for ActiveRecord ORM
# use_orm :activerecord

### Uncomment for Sequel ORM
# use_orm :sequel


### This defines which test framework the generators will use
### rspec is turned on by default
###
### Note that you need to install the merb_rspec if you want to ue
### rspec and merb_test_unit if you want to use test_unit. 
### merb_rspec is installed by default if you did gem install
### merb.
###
# use_test :test_unit
# use_test :rspec

### Add your other dependencies here

# These are some examples of how you might specify dependencies.
# 
dependencies 'merb-action-args', 'merb-assets', 'merb-haml', 'merb_helpers', 'RedCloth', 'uri'
# OR
# dependency "RedCloth", "> 3.0"
# OR
# dependencies "RedCloth" => "> 3.0", "ruby-aes-cext" => "= 1.0"

Dir.glob(Merb.root / 'app' / 'controllers' / 'pages_mixins/*.rb').each { |mixin| require mixin }

Merb::BootLoader.after_app_loads do
  if Merb.environment == 'development'
    Merb.logger.info('Auto migrating development database')
    DataMapper::Persistence.auto_migrate! 
    require Merb.root / 'db' / 'seed_dev'
  end
  
  require Merb.root / 'lib' / 'core_ext' / 'try'
end
