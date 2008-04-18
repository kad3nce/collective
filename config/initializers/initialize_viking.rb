# Sometimes Viking isn't loaded at this point, so we make sure it is here
unless Object.const_defined?("Viking")
  require Merb.root / 'lib' / 'viking' / 'viking'
end

# This needs to load before the app so Pages can load the appropriate module 
# for it's +create+ and +update+ methods
Merb::BootLoader.before_app_loads do
  
  config_path = Merb.root / 'config' / 'spam_protection.yml'
  
  # Initialize Viking with all the information it needs to use the 
  # spam protection service of choice
  if File.exists?(config_path) 
    unless (config = YAML.load_file(config_path))[:api].blank?
      Viking.default_engine  = config[:api]
      Viking.connect_options = config[:connect_options]
    end
  end
  
end