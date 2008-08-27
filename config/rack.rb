if prefix = ::Merb::Config[:path_prefix]
  use Merb::Rack::PathPrefix, prefix
end
use Merb::Rack::Static, Merb.dir_for(:public)
run Merb::Rack::Application.new