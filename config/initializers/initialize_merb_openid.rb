Merb::BootLoader.before_app_loads do
  Merb::Config[:merb_openid][:store] = OpenIDDataMapper::DataMapperStore.new  
end
