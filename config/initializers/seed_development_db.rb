# Merb::BootLoader.after_app_loads do
#   if Merb.environment == 'development'
#     begin
#       require Merb.root / 'db' / 'seed_dev' unless Page.count > 0
#     rescue DataObject::QueryError
#       # Database not set up yet; don't try to seed it.
#     end
#   end
# end