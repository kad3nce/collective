require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/merb_exceptions'

# Mock out Merb bits that a re required for testing
module Merb
  class Plugins
    def self.config; NotificationSpecHelper.merb_config || {}; end
  end
  
  class Logger
    def info(msg=''); msg; end
  end
  
  class << self
    def env; 'production'; end
    def logger; Logger.new; end
  end
end

module NotificationSpecHelper
  def mock_details(opts={})
    {
      'exception'      => {},
      'params'         => { :controller=>'errors', :action=>'show' },
      'environment'    => { 'key1'=>'value1', 'key2'=>'value2' },
      'url'            => 'http://www.my-app.com/errors/1'
    }.merge(opts)
  end
  
  def default_config
    {
      :web_hooks       => [],
      :email_addresses => [],
      :app_name        => "Merb Application",
      :environments    => ['production']
    }
  end
  
  def mock_merb_config(opts={})
    NotificationSpecHelper.merb_config = {:exceptions => opts}
  end
  
  class << self
    attr_accessor :merb_config
  end
end