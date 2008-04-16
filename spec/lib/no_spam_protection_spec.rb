require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Pages, "with no spam protection" do

  attr_accessor :page
  
  before(:each) do
    self.page = Page.new
    Pages.send(:include, NoSpamProtection)
  end
  
  after(:each) do
    self.page = nil
  end
  
  it "should include the NoSpamProtection module" do
    Pages.should include(NoSpamProtection)
  end

  describe "requesting /pages with POST" do
    before(:each) do
      page.stub!(:save).and_return(true)
      Page.stub!(:new).and_return(page)
    end
    
    def do_post
      dispatch_to(Pages, :create, :page => {})
    end
    
    it "should create a new page" do
      page.should_receive(:save).and_return(true)
      do_post
    end
    
    it "should redirect_to the new page if creating was successful" do
      do_post.should be_redirection_to(url(:page, page))
    end
    
    it "should render 'new' if the page was invalid" do
      page.should_receive(:save).and_return(false)
      dispatch_to(Pages, :create) do |controller|
        controller.should_receive(:render).with(:new)
      end
    end
  end

  describe "requesting /pages/1 with PUT" do
    before(:each) do
      page.stub!(:update_attributes).and_return(true)
      Page.stub!(:by_slug).and_return(page)
    end
    
    def do_put
      dispatch_to(Pages, :update, :id => "1", :page => {}) do |controller|
        controller.stub!(:render)
      end
    end
    
    it "should load the requested page record" do
      Page.should_receive(:by_slug).with("1").and_return(page)
      do_put.assigns(:page).should == page
    end
    
    it "should redirect_to the page record if the update was successful" do
      page.should_receive(:update_attributes).and_return(true)
      do_put.should be_redirection_to(url(:page, page))
    end
    
    it "should render the 'edit' view if the update failed" do
      page.should_receive(:update_attributes).and_return(false)
      
      dispatch_to(Pages, :update, :id => "1", :page => {}) do |controller|
        controller.should_receive(:render).with(:edit)
      end
    end
  end

end