require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Edits do

  attr_accessor :edit, :edits
  
  before(:each) do
    self.edit  = stub_everything("version")
    self.edits = [edit]
    
    edit.stub!(:id).and_return("1")
  end
  
  after(:each) do
    self.edit  = nil
    self.edits = nil
  end
  
  describe "requesting /edits with GET" do
    
    before(:each) do
      Version.stub!(:most_recent_unmoderated).and_return(edits)
    end
    
    def do_get_successfully
      dispatch_to(Edits, :index) do |controller|
        controller.stub!(:authenticate_or_request_with_http_basic).and_return(true)
        controller.stub!(:display)
      end
    end
    
    def do_get_without_authentication
      dispatch_to(Edits, :index)
    end
    
    it "should be successful" do
      do_get_successfully.status.should == 200
    end
    
    it "should load the most recent Versions available" do
      Version.should_receive(:most_recent_unmoderated).and_return(edits)
      do_get_successfully.assigns(:edits).should == edits
    end
    
    it "should display the loaded Version records" do
      dispatch_to(Edits, :index) do |controller|
        controller.stub!(:authenticate_or_request_with_http_basic).and_return(true)
        controller.should_receive(:display).with(edits)
      end
    end
    
    it "should return an HTTP 401 (UNAUTHORIZED) response if the user isn't authenticated" do
      do_get_without_authentication.status.should == 401
    end
    
  end

  describe "requesting /edits/1 with PUT" do
    
    before(:each) do
      Version.stub!(:first).and_return(edit)
      edit.stub!(:update_attributes).and_return(true)
    end
    
    def do_authorized_put
      dispatch_to(Edits, :update, :id => "1") do |controller|
        controller.stub!(:authenticate_or_request_with_http_basic).and_return(true)
      end
    end
    
    def do_unauthorized_put
      dispatch_to(Edits, :update, :id => "1")
    end
    
    it "should redirect to /edits" do
      do_authorized_put.should be_redirection_to(url(:edits))
    end
    
    it "should load the requested record" do
      Version.should_receive(:first).with("1").and_return(edit)
      do_authorized_put.assigns(:edit).should == edit
    end
    
    it "should raise NotFound if the record cannot be found" do
      Version.should_receive(:first).with("1").and_return(nil)
      lambda { do_authorized_put }.should raise_error(Merb::ControllerExceptions::NotFound)
    end
    
    it "should set the record as moderated" do
      edit.should_receive(:update_attributes).with(:moderated => true).and_return(true)
      do_authorized_put.should be_redirection_to(url(:edits))
    end 
    
    it "should raise BadRequest if the update fails" do
      edit.should_receive(:update_attributes).with(:moderated => true).and_return(false)
      lambda { do_authorized_put }.should raise_error(Merb::ControllerExceptions::BadRequest)
    end
    
    it "should respond with a client error (HTTP 401) if accessed by an unauthorized user" do
      do_unauthorized_put.should be_client_error
    end
  end

end