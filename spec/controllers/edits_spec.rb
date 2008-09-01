require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Edits do
  attr_accessor :edit, :edits
  
  def do_get
    dispatch_with_basic_authentication_to(Edits, :index, Collective.admin_username, Collective.admin_password) do |controller|
      controller.stub!(:display)
      yield(controller) if block_given?
    end
  end
  
  before(:each) do
    @edit  = Version.new(
      :content   => 'I have content', 
      :signature => 1234, 
      :spam      => false
    )
    @edits = [@edit]
  end
  
  describe 'requesting /edits with GET' do
    before(:each) do
      Version.stub!(:most_recent_unmoderated).and_return(@edits)
    end
    
    it 'should be successful' do
      do_get.should be_successful
    end
    
    it 'should render the records' do
      do_get do |controller|
        controller.should_receive(:display).with(@edits)
      end
    end
    
    it 'should load the most recent Versions available' do
      Version.should_receive(:most_recent_unmoderated).and_return(@edits)
      do_get.assigns(:edits).should == @edits
    end
    
    it "should return an HTTP 401 (UNAUTHORIZED) response if the user isn't authenticated" do
      dispatch_to(Edits, :index).status.should == 401
    end
  end

  describe 'requesting /edits with GET but without edit' do
    before(:each) do
      Version.stub!(:most_recent_unmoderated).and_return(nil)
    end
    
    it 'should be successful' do
      do_get.should be_successful
    end
    
    it 'should render the records' do
      a = do_get do |controller|
        controller.should_receive(:display).with(nil)
      end
    end
    
    it "should return an HTTP 401 (UNAUTHORIZED) response if the user isn't authenticated" do
      dispatch_to(Edits, :index).status.should == 401
    end

  end

  describe 'requesting /edits/1 with GET' do
    
    def do_get
      dispatch_with_basic_authentication_to(Edits, :show, Collective.admin_username, Collective.admin_password, :id => '1') do |controller|
        controller.stub!(:display)
        yield(controller) if block_given?
      end
    end

    before(:each) do
      @page = mock_model(Page)
      Page.stub!(:by_slug).and_return(@page)
    end

    it 'should be successful' do
      do_get.should be_successful
    end

    it 'should load the requested Page by the specified slug' do
      Page.should_receive(:by_slug).and_return(@page)
      do_get.assigns(:page).should == @page
    end
    
    it 'should raise NotFound if a record cannot be found with the specified slug' do
      Page.should_receive(:by_slug).and_return(nil)
      lambda { do_get }.should raise_error(Merb::ControllerExceptions::NotFound)
    end
    
    it 'should display the Page history' do
      do_get do |controller|
        controller.should_receive(:display).with(@page)
      end
    end
    
  end
  
  describe 'requesting /edits/1 with PUT' do
    
    before(:each) do
      Version.stub!(:first).and_return(@edit)
      Viking.stub!(:mark_as_spam)
      Viking.stub!(:mark_as_ham)
      Viking.stub!(:enabled?).and_return(true)
      @edit.stub!(:update_attributes).and_return(true)
    end
    
    def do_put
      dispatch_with_basic_authentication_to(Edits, :update, Collective.admin_username, Collective.admin_password, :id => "1", :page => {})
    end
    
    def do_xhr_put
      dispatch_with_basic_authentication_to(Edits, :update, Collective.admin_username, Collective.admin_password, {:id => "1", :page => {}}, {:http_x_requested_with => "XMLHttpRequest"})
    end
    
    it 'should load the requested Version' do
      Version.should_receive(:get!).with("1").and_return(@edit)
      do_put.assigns(:edit).should == @edit
    end
    
    it 'should raise NotFound if an invalid ID is provided' do
      Version.should_receive(:get!).with("1").and_return(nil)
      lambda { do_put }.should raise_error(Merb::ControllerExceptions::NotFound)
    end
    
    it "should update the record's attributes" do
      @edit.should_receive(:update_attributes).and_return(true)
      do_put
    end
    
    it 'should notify the anti-spam service that this version is spam if it was marked as ham' do
      Viking.should_receive(:mark_as_spam).with(:signatures => @edit.signature)
      do_put
    end
    
    it 'should notify the anti-spam service that this version is ham if it was marked as spam' do
      @edit.stub!(:spam?).and_return(true)
      Viking.should_receive(:mark_as_ham).with(:signatures => @edit.signature)
      do_put
    end
    
    it 'should redirect_to /edits if the update was successful' do
      do_put.should be_redirection_to(url(:edits))
    end
    
    it 'should render nothing if the request is XHR' do
      do_xhr_put.should be_successful
    end
    
    it 'should not require Viking to update a Version' do
      Viking.should_receive(:enabled?).and_return(false)
      do_put.should be_redirection_to(url(:edits))
    end
  end
  
end
