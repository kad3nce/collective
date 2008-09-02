require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

# A fake controller to play with. This prevents any confusion that might 
# arise because of how spam protection (or lack thereof) is included into the 
# Pages controller where it is normally used.
class NotSpamProtected < Application
  include NoSpamProtection
end

# Note that even though we're actually using a fake controller, we still talk 
# about the Pages controller. This is only to prevent confusion at a later 
# date when reading a specdoc.
describe Pages, "with no spam protection" do
  
  before(:each) do
    @page = Page.new
    @version = Version.new
  end
  
  it 'should include the NoSpamProtection module' do
    NotSpamProtected.should include(NoSpamProtection)
  end

  describe 'requesting /pages with POST' do
    before(:each) do
      @page.stub!(:valid?).and_return(true)
      @page.stub!(:save).and_return(true)
      Page.stub!(:new).and_return(@page)
      @version.stub!(:valid?).and_return(true)
      @version.stub!(:save).and_return(true)
      Version.stub!(:new).and_return(@version)
    end
    
    
    def do_post
      dispatch_to(NotSpamProtected, :create, {:page => {:name => 'new page'}, :version => {:content => 'a tutorial'}})
    end
    
    it "should create a new page" do
      @page.should_receive(:save).and_return(true)
      do_post
    end
    
    it "should redirect_to the new page if creating was successful" do
      do_post.should be_redirection_to(url(:page, @page))
    end
    
    it "should render 'new' if the page was invalid" do
      @page.should_receive(:valid?).and_return(false)
      dispatch_to(NotSpamProtected, :create, {:page => {:name => 'new page'}, :version => {:content => 'a tutorial'}}) do |controller|
        controller.should_receive(:render).with(:new)
      end
    end
  end

  describe "requesting /pages/1 with PUT" do
    before(:each) do
      Page.stub!(:by_slug).and_return(@page)
      Version.stub!(:new).and_return(@version)
      @version.stub!(:save).and_return(true)
    end
    
    def do_put
      dispatch_to(NotSpamProtected, :update, :id => "1", :version => {:content => 'an updated tutorial'}) do |controller|
        controller.stub!(:render)
      end
    end
    
    it 'should load the requested page record' do
      Page.should_receive(:by_slug).with('1').and_return(@page)
      do_put.assigns(:page).should == @page
    end

    it 'should initialize a new version record' do
      Version.should_receive(:new).and_return(@version)
      do_put.assigns(:version).should == @version
    end
    
    it 'should redirect_to the page record if the update was successful' do
      @version.should_receive(:save).and_return(true)
      do_put.should be_redirection_to(url(:page, @page))
    end
    
    it "should render the 'edit' view if the update failed" do
      @version.should_receive(:save).and_return(false)
      dispatch_to(NotSpamProtected, :update, :id => "1", :version => {:content => 'an updated tutorial'}) do |controller|
        controller.should_receive(:render).with(:edit)
      end
    end
  end
end