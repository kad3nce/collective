require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Pages do
  
  attr_accessor :page, :pages
  
  before(:each) do
    self.page = mock_model(Page)
    self.pages = [page]
  end
  
  after(:each) do
    self.page  = nil
    self.pages = nil
  end
  
  describe "requesting /pages with GET" do
    before(:each) do
      Page.stub!(:all).and_return(pages)
    end
    
    def do_get
      dispatch_to(Pages, :index) do |controller|
        controller.stub!(:display)
      end
    end
    
    it "should be successful" do
      do_get.should be_successful
    end
    
    it "should load all page records" do
      Page.should_receive(:all).and_return(pages)
      do_get.assigns(:pages).should == pages
    end
    
    it "should display all pages" do
      dispatch_to(Pages, :index) do |controller|
        controller.should_receive(:display).with(pages)
      end
    end
  end
  
  describe "requesting /pages/new with GET" do
    def do_get
      dispatch_to(Pages, :new) do |controller|
        controller.stub!(:render)
      end
    end
    
    it "should be successful" do
      do_get.should be_successful
    end
    
    it "should initialize a new Page instance" do
      do_get.assigns(:page).should be_a_kind_of(Page)
      do_get.assigns(:page).should be_a_new_record
    end
    
    it "should render the current action" do
      dispatch_to(Pages, :new) do |controller|
        controller.should_receive(:render)
      end
    end
  end

end