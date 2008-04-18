Merb::BootLoader.after_app_loads do
  if Merb.environment == 'development'
    # Merb.logger.info('Auto migrating development database')
    # DataMapper::Persistence.auto_migrate! 
    require Merb.root / 'db' / 'seed_dev' unless Page.count > 0
  end
end