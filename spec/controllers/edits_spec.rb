require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Edits do

  attr_accessor :edit, :edits
  
  before(:each) do
    self.edit  = Version.new(:content => "I have content")
    self.edits = [edit]
  end
  
  after(:each) do
    self.edit  = nil
    self.edits = nil
  end
  
  describe "requesting /edits with GET" do
    
    before(:each) do
      Version.stub!(:all).and_return(edits)
    end
    
    def do_get_successfully
      dispatch_to(Edits, :index) do |controller|
        controller.stub!(:authenticate_or_request_with_http_basic).and_return(true)
      end
    end
    
    def do_get_without_authentication
      dispatch_to(Edits, :index)
    end
    
    it "should be successful" do
      do_get_successfully.status.should == 200
    end
    
    it "should load the most recent Versions available" do
      Version.should_receive(:all).and_return(edits)
      do_get_successfully.assigns(:edits).should == edits
    end
    
    it "should return an HTTP 401 (UNAUTHORIZED) response if the user isn't authenticated" do
      do_get_without_authentication.status.should == 401
    end 
    
  end

end
