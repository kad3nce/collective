require File.join(File.dirname(__FILE__), '..',  'spec_helper')

describe Page do
  
  describe '.new' do
    it 'should have a name property' do
      Page.new(:name => 'A super informative page').name.should == 'A super informative page'
    end

    it 'should have a slug property' do
      Page.new(:slug => 'a-super-informative-page').slug.should == 'a-super-informative-page'
    end

    it 'should have a spam property' do
      Page.new(:spam => true).spam.should == true
    end

    it 'should have many versions' do
      Page.new.versions.should be_an_instance_of(DataMapper::Associations::HasManyAssociation::Set)
    end

    it 'should have a versions_count property' do
      Page.new(:versions_count => 10).versions_count.should == 10
    end
  end
  
  describe '#build_new_version' do
    
    before(:each) do
      @page = Page.new(
        :content => 'the body of the page', 
        :name    => 'a new page'
      )
      @page.versions_count = 1
      
      @page.stub!(:valid?).and_return(true)
      @page.stub!(:versions).and_return(stub('versions', :create => true, :deactivate => true))
    end
    
    after(:each) do
      @page = nil
    end
    
    it 'should increment versions_count if the page is not spam' do
      @page.spam = false
      Page.publicize_methods(@page) do |p|
        lambda { p.build_new_version }.should change(p, :versions_count)
      end
    end
    
    it 'should not increment versions_count if the page is spam' do
      @page.spam = true
      Page.publicize_methods(@page) do |p|
        lambda { p.build_new_version }.should_not change(p, :versions_count)
      end
    end
    
    it 'should build a new Version' do
      @page.should_receive(:versions).and_return(mock('versions', :create => true))
      Page.publicize_methods(@page) do |p|
        p.build_new_version
      end
    end
  end
  
  describe '#version_attributes' do
    it "should set the 'spam' attribute to true if the Page is spam" do
      Page.publicize_methods do
        Page.new(:spam => true, :versions_count => 0).version_attributes[:spam].should be_true
      end
    end
  end

  describe '#latest_version' do

    before(:each) do
      @page = Page.new
      @page.stub!(:id).and_return(1)
      
      @version = mock_model(Version)
    end
    
    after(:each) do
      @page    = nil
      @version = nil
    end
    
    it 'should return that most recent version for this page' do
      Version.should_receive(:latest_version_for_page).with(@page).and_return(@version)
      @page.latest_version.should == @version
    end
  end

  describe 'content methods' do
    
    before(:each) do
      @page = Page.new
      @page.stub!(:latest_version).and_return(
        stub('latest', 
          :content      => 'the content', 
          :content_html => '<p>the content</p>'
        )
      )
    end
    
    after(:each) do
      @page = nil
    end

    describe '#content' do
      it 'should fetch the content from the latest version' do
        @page.content.should == 'the content'
      end

      it 'should return an empty string if #latest_version is nil' do
        Page.new.content.should == ''
      end
    end

    describe "#content=" do
      it "should set the content of the page" do
        p = Page.new
        p.content = "Content for page"
        p.content.should == "Content for page"
      end

      it "should set the diff of the new html content and the old html content" do
        p = Page.new
        p.content = "Content for *page*"
        # p.content = [p.content, "Content for diff"].join("\n")
        p.content_diff.should == "\n<p>Content for <b>diff</b></p>"
      end
    end

    describe '#content_html' do
      it 'should fetch the html formatted content from the latest version' do
        @page.content_html.should == '<p>the content</p>'
      end

      it 'should return an empty string if #latest_version is nil' do
        Page.new.content_html.should == ''
      end
    end
  end
  
  describe '#name' do
    
    before(:each) do
      @existing_page = Page.new(:name => 'Existing name')
      @existing_page.stub!(:new_record?).and_return(false)
    end
    
    after(:each) do
      @existing_page = nil
    end
    
    it "should set a new record's name" do
      p = Page.new(:name => 'My name is Jonas')
      p.name.should == 'My name is Jonas'
    end
    
    it "should not allow an existing page's name to be overwritten" do
      old_name = @existing_page.name
      
      @existing_page.name = 'I want a new name'
      @existing_page.name.should == old_name
    end
  end
  
  describe "#select_version!" do
    
    before(:each) do
      @page = Page.new
      @initial_version = Version.new(
        :content      => 'Initial Content', 
        :content_html => '<p>Initial Content</p>', 
        :number       => 1
      )
      @updated_version = Version.new(
        :content      => 'Updated Content', 
        :content_html => '<p>Updated Content</p>', 
        :number       => 2
      )
      @page.versions << @initial_version
      @page.versions << @updated_version
      
      Version.stub!(:latest_version_for_page).and_return(@updated_version)
    end
    
    after(:each) do
      @page.destroy!
      @initial_version.destroy!
      @updated_version.destroy!
    end
    
    it "should select the latest version if no version number was specified" do
      @page.select_version!
      @page.selected_version.should == @updated_version
    end
    
    it "should select the latest version if 'nil' is specified as the version number" do
      @page.select_version!(nil)
      @page.selected_version.should == @updated_version
    end
    
    it "should select the latest version if ':latest' is specified as the version number" do
      @page.select_version!(:latest)
      @page.selected_version.should == @updated_version
    end
    
    it "should select the specified version number" do
      @page.select_version!(@initial_version.number)
      @page.selected_version.should == @initial_version
    end
    
    it "should select the specified version number when it's a string" do
      @page.select_version!(@initial_version.number.to_s)
      @page.selected_version.should == @initial_version
    end
    
    it "should return 'nil' if the specified version number is invalid" do
      @page.versions.should_receive(:detect).and_return(nil)
      @page.select_version!(3).should be_nil
    end
    
    it "should set 'content' to the selected version's content" do
      @page.select_version!(@initial_version.number)
      @page.content.should == @initial_version.content
    end
    
    it "should set 'content_html' to the selected version's content_html" do
      @page.select_version!(@initial_version.number)
      @page.content_html.should == @initial_version.content_html
    end
  end
  
  describe 'slug characteristics' do
    it 'should be the page name' do
      @page = Page.new(:name => 'asuperinformativepage')
      @page.valid?
      @page.slug.should == 'asuperinformativepage'
    end

    it 'should be set before validations' do
      @page = Page.new(:name => 'asuperinformativepage')
      @page.slug.should be_nil
      @page.valid?
      @page.slug.should == 'asuperinformativepage'
    end
    
    it 'should be the page name downcased' do
      @page = Page.new(:name => 'ASuperInformativePage')
      @page.valid?
      @page.slug.should == 'asuperinformativepage'
    end
    
    it 'should be the page name with spaces dasherized' do
      @page = Page.new(:name => 'a super informative page')
      @page.valid?
      @page.slug.should == 'a-super-informative-page'
    end
    
    it 'should be the page name with non-word characters dasherized' do
      @page = Page.new(:name => 'a/super/informative/page')
      @page.valid?
      @page.slug.should == 'a-super-informative-page'
    end
  end
  
  describe '#to_param' do
    it "should return the page's slug" do
      Page.new(:slug => 'a-slug').to_param.should == 'a-slug'
    end
  end
  
  describe '.by_slug_and_select_version!' do
    
    before(:each) do
      @version = stub('version')
      @page    = stub('page', :select_version! => true, :selected_version => @version)
      Page.stub!(:by_slug).and_return(@page)
    end
    
    after(:each) do
      @page = nil
    end
    
    it 'should return the page with the specified slug' do
      Page.by_slug_and_select_version!('slug', 1).should == @page
    end
    
    it 'should return nil if the slug is invalid' do
      Page.should_receive(:by_slug).and_return(nil)
      Page.by_slug_and_select_version!('slug', 1).should be_nil
    end
    
    it 'should select the specified version of the slug' do
      @page.should_receive(:select_version!).with(1)
      Page.by_slug_and_select_version!('slug', 1).selected_version.should == @version
    end
    
    it 'should return nil if the specified version is invalid' do
      @page.should_receive(:selected_version).and_return(nil)
      Page.by_slug_and_select_version!('slug', 1).should be_nil
    end
  end
  
  describe '.versions' do
    it 'should not include any versions marked as spam' do
      @page = Page.create!(:name => 'A Page', :content => 'blah')
      @page.update_attributes(:content => 'spam', :spam => true)
      Page[@page.id].versions.length.should == 1
    end
  end
  
end
