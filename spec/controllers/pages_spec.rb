require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Pages do
  
  attr_accessor :page, :pages
  
  before(:each) do
    self.page = mock_model(Page)
    self.pages = [page]
    
    Page.stub!(:by_slug_and_select_version!).and_return(page)
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

  describe "requesting /pages/1 with GET" do
    def do_get(params={})
      dispatch_to(Pages, :show, { :id => "1" }.update(params)) do |controller|
        controller.stub!(:display)
      end
    end
    
    it "should be successful" do
      do_get.should be_successful
    end
    
    it "should load the requested Page by the specified slug" do
      Page.should_receive(:by_slug_and_select_version!).and_return(page)
      do_get.assigns(:page).should == page
    end
    
    it "should raise NotFound if a record cannot be found with the specified slug" do
      Page.should_receive(:by_slug_and_select_version!).and_return(nil)
      lambda { do_get }.should raise_error(Merb::ControllerExceptions::NotFound)
    end
    
    it "should display the Page record" do
      dispatch_to(Pages, :show, :id => "1") do |controller|
        controller.should_receive(:display).with(page)
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