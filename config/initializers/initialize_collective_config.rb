require 'ostruct'
require 'fileutils'

Merb::BootLoader.before_app_loads do
  config_path = Merb.root / 'config' / 'collective.yml'
  
  if File.exists?(config_path) 
    Collective = OpenStruct.new(YAML.load_file(config_path))
  else
    FileUtils.cp(Merb.root / 'config' / 'collective.yml.sample', config_path)
    Merb.logger.error! "No collective.yml file found in #{Merb.root}/config."
    Merb.logger.error! "A sample file was created called collective.yml for you to edit."
    exit(1)
  end
  
end