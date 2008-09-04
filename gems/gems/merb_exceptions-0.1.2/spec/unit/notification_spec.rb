require File.dirname(__FILE__) + '/../spec_helper'

include MerbExceptions
include NotificationSpecHelper

describe MerbExceptions::Notification do
  describe "#new" do
    it "should create a new notification without errors" do
      lambda { Notification.new(mock_details) }.should_not raise_error
    end
    
    it "should set the detail values to those provided" do
      Notification.new(mock_details).details.should == mock_details
    end
    
    it "should set config defaults when values aren't provided" do
      config = Notification.new(mock_details).instance_variable_get(:@config)
      config.should == default_config
    end
    
    it "should allow overriding of default configuration options through the Merb::Plugins.config hash" do
      opts = { :app_name=>'Testy Mc Testerson', :email_addresses=>['test1@test.com', 'test2@test.com'] }
      mock_merb_config(opts)
      config = Notification.new(mock_details).instance_variable_get(:@config)
      config.should == default_config.merge(opts)
    end
  end
  
  describe ".deliver!" do
    before :each do
      @notification = Notification.new(mock_details)
      @notification.stub!('deliver_emails!')
      @notification.stub!('deliver_web_hooks!')
    end
    
    it "should deliver web hooks" do
      @notification.should_receive('deliver_web_hooks!')
      @notification.deliver!
    end

    it "should deliver emails" do
      @notification.should_receive('deliver_emails!')
      @notification.deliver!
    end
  end
  
  describe ".deliver_web_hooks!" do
    before :each do
      mock_merb_config({ :web_hooks => ['http://www.test1.com', 'http://www.test2.com'] })
      @notification = Notification.new(mock_details)
      @notification.stub!(:post_hook)
    end
    
    it "should call post_hook for each url" do
      @notification.should_receive(:post_hook).once.with('http://www.test1.com')
      @notification.should_receive(:post_hook).once.with('http://www.test2.com')
      @notification.deliver_web_hooks!
    end
  end

  describe ".deliver_emails!" do
    before :each do
      mock_merb_config({ :email_addresses => ['user1@test.com', 'user2@test.com'] })
      @notification = Notification.new(mock_details)
      @notification.stub!(:send_notification_email)
    end

    it "should call send_notification_email for each address" do
      @notification.should_receive(:send_notification_email).once.with('user1@test.com')
      @notification.should_receive(:send_notification_email).once.with('user2@test.com')
      @notification.deliver_emails!
    end
  end
  
  describe ".should_deliver_notifications?" do
    it "should return true if the current environment is on the config[:environments] list of one item" do
        mock_merb_config({ :environments => 'production' })
        Notification.new(mock_details).should_deliver_notifications?.should be_true
    end
    
    it "should return true if the current environment is on the config[:environments] list as an array" do
        mock_merb_config({ :environments => ['staging', 'production'] })
        Notification.new(mock_details).should_deliver_notifications?.should be_true
    end

    it "should return false if the current environment is not on the config[:environments] list" do
        mock_merb_config({ :environments => ['staging', 'development'] })
        Notification.new(mock_details).should_deliver_notifications?.should be_false
    end
  end
end