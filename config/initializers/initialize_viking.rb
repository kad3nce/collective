Merb::BootLoader.after_app_loads do
  
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