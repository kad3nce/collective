require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

# A fake controller to play with. This prevents any confusion that might 
# arise because of how spam protection (or lack thereof) is included into the 
# Pages controller where it is normally used.
class SpamProtected < Application
  include SpamProtection
end

# Note that even though we're actually using a fake controller, we still talk 
# about the Pages controller. This is only to prevent confusion at a later 
# date when reading a specdoc.
describe Pages, "with spam protection" do
  
  before(:each) do
    @page     = Page.new
    @version  = Version.new(:content => 'this is some content')
    @version.stub!(:valid?).and_return(true)
    @version.stub!(:save).and_return(true)
    @version.stub!(:additions).and_return('the new text')
    @response = {
      :spaminess => 0.1, 
      :signature => '1234', 
      :spam      => true
    }
    
    Viking.stub!(:check_comment).and_return(@response)
    Viking.stub!(:enabled?).and_return(true)
  end
  
  it 'should include the SpamProtection module' do
    SpamProtected.should include(SpamProtection)
  end

  describe 'requesting /pages with POST' do
    before(:each) do
      @page.stub!(:valid?).and_return(true)
      @page.stub!(:save).and_return(true)
      Page.stub!(:new).and_return(@page)
      Version.stub!(:create_spam)
    end
    
    def do_post
      dispatch_to(SpamProtected, :create, {:page => {:name => 'new page'}, :version => {:content => 'a tutorial'}})
    end
    
    it 'should redirect to /pages if a new page record was successfully created' do
      do_post.should be_redirection_to(url(:pages))
    end
    
    it 'should check the comment with the spam engine' do
      Viking.should_receive(:check_comment).and_return(@response)
      do_post
    end
    
    it 'should create a new spam Version if Viking responds as spam' do
      @response.update(:spam => true)
      Version.should_receive(:create_spam)
      
      do_post
    end
    
    it "should save Viking's response signature if it isn't spam" do
      @response.update(:spam => false)
      do_post.assigns(:version).signature.should == @response[:signature]
    end
    
    it "should save Viking's spaminess measurement if it isn't spam" do
      @response.update(:spam => false)
      do_post.assigns(:version).spaminess.should == @response[:spaminess]
    end
    
    it "should save the new Page if it isn't spam" do
      @response.update(:spam => false)
      @page.should_receive(:save)
      do_post
    end
    
    it "should render the 'new' action if the Page isn't valid" do
      @page.should_receive(:valid?).and_return(false)
      dispatch_to(SpamProtected, :create, :page => {:name => 'new page'}, :version => {:content => 'a tutorial'}) do |controller|
        controller.should_receive(:render).with(:new)
      end
    end
  end

  describe 'requesting /pages/1 with PUT' do
    before(:each) do
      @page.stub!(:update_attributes).and_return(true)
      Page.stub!(:by_slug).and_return(@page)
      Version.stub!(:new).and_return(@version)
    end
    
    def do_put
      dispatch_to(SpamProtected, :update, :id => "1", :version => {:content => 'a tutorial'})
    end
    
    it 'should load the requested Page record' do
      Page.should_receive(:by_slug).with("1").and_return(@page)
      do_put.assigns(:page).should == @page
    end
    
    it 'should raise NotFound if the provided ID is invalid' do
      Page.should_receive(:by_slug).with("1").and_return(nil)
      lambda { do_put }.should raise_error(Merb::ControllerExceptions::NotFound)
    end
    
    it 'should redirect to the page record if successful' do
      do_put.should be_redirection_to(url(:page, @page))
    end
    
    it 'should check to see if the changes are spam' do
      Viking.should_receive(:check_comment).and_return(@response)
      do_put
    end
    
    it "should save the new version" do
      Version.stub!(:new).and_return(@version)
      @version.should_receive(:save)
      do_put
    end
    
    it "should render 'edit' if the submission fails validation" do
      Version.stub!(:new).and_return(@version)
      @version.should_receive(:valid?).and_return(false)
      dispatch_to(SpamProtected, :update, :id => '1', :version => {:content => 'a tutorial'}) do |controller|
        controller.should_receive(:render).with(:edit)
      end
    end
  end
end