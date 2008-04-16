require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Pages, "with spam protection" do

  attr_accessor :page, :response
  
  before(:each) do
    self.page = Page.new
    Page.stub!(:new).and_return(page)
    
    self.response = {
      :spaminess => 0.1, 
      :signature => 1234, 
      :spam      => true
    }
    Viking.stub!(:check_comment).and_return(response)
  end
  
  after(:each) do
    self.response = nil
    self.page     = nil
  end
  
  it "should include the SpamProtection module" do
    Pages.should include(SpamProtection)
  end

  describe "requesting /pages with POST" do
    before(:each) do
      page.stub!(:valid?).and_return(true)
      page.stub!(:save).and_return(true)
      Version.stub!(:create_spam)
    end
    
    def do_post
      dispatch_to(Pages, :create, :page => {})
    end
    
    it "should redirect to /pages if a new page record was successfully created" do
      do_post.should be_redirection_to(url(:pages))
    end
    
    it "should check the comment with the spam engine" do
      Viking.should_receive(:check_comment).and_return(response)
      do_post
    end
    
    it "should create a new spam Version if Viking responds as spam" do
      response.update(:spam => true)
      Version.should_receive(:create_spam)
      
      do_post
    end
    
    it "should save Viking's response signature if it isn't spam" do
      response.update(:spam => false)
      do_post.assigns(:page).signature.should == response[:signature]
    end
    
    it "should save Viking's spaminess measurement if it isn't spam" do
      response.update(:spam => false)
      do_post.assigns(:page).spaminess.should == response[:spaminess]
    end
    
    it "should save the new Page if it isn't spam" do
      response.update(:spam => false)
      page.should_receive(:save)
      do_post
    end
    
    it "should render the 'new' action if the Page isn't valid" do
      page.should_receive(:valid?).and_return(false)
      dispatch_to(Pages, :create, :page => {}) do |controller|
        controller.should_receive(:render).with(:new)
      end
    end
  end

end