Merb::BootLoader.before_app_loads do
  # Load our goodies in lib
  Dir[Merb.root / 'lib' / '**' / '*.rb'].each do |ext|
    require(ext)
  end
end