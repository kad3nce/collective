Merb::BootLoader.after_app_loads do
  # Load core extensions
  Dir[Merb.root / 'lib' / 'core_ext' / '*.rb'].each do |core_ext|
    require(core_ext)
  end
  
  # Load controller mixins
  require Merb.root / 'lib' / 'controller' / 'mixins' / 'controller'
end