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
# Gems
gem 'diff-lcs', '=1.1.2'
require 'diff/lcs'
require 'diff/lcs/hunk'
gem 'dm-validations', '=0.9.5'
require 'dm-validations'
gem 'dm-migrations', '=0.9.5'
require 'dm-migrations'
gem 'dm-timestamps',  '=0.9.5'
require 'dm-timestamps'
gem 'merb-action-args', '=0.9.5'
require 'merb-action-args'
gem 'merb-assets', '=0.9.5'
require 'merb-assets'
gem 'merb-haml', '=0.9.5'
require 'merb-haml'
gem 'merb_helpers', '=0.9.4'
require 'merb_helpers'
gem 'merb-parts', '=0.9.5'
require 'merb-parts'
gem 'RedCloth', '3.0.4'
require 'redcloth'
gem 'vikinggem', '0.0.3'
require 'viking'

# Standard Libraries
require 'iconv'
require 'open-uri'

# Load initializers
Dir[Merb.root / 'config' / 'initializers' / '*.rb'].each do |initializer|
  load(initializer)
end
