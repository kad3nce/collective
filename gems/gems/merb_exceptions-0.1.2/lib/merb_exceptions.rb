unless defined?(Merb::Plugins)
  raise %q{merb_exceptions says, "Something's not right, bub.  You should run me inside Merb."}
end

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "merb_exceptions/notification"
require 'merb_exceptions/controller_extensions'

module MerbExceptions
  
end
