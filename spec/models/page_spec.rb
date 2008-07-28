require File.join(File.dirname(__FILE__), '..',  'spec_helper')

describe Page do
  
  describe '.new' do
    it 'should have a name property' do
      Page.new(:name => 'A super informative page').name.should == 'A super informative page'
    end

    it 'should have a slug property' do
      Page.new(:slug => 'a-super-informative-page').slug.should == 'a-super-informative-page'
    end

    it 'should have version_attributes property' do
      Page.new(:version_attributes => {}).version_attributes.should == {}
    end

    it 'should have many versions' do
      Page.new.versions.should be_an_instance_of(DataMapper::Associations::HasManyAssociation::Set)
    end

    it 'should have a versions_count property' do
      Page.new(:versions_count => 10).versions_count.should == 10
    end
  end
  
  describe 'content methods' do
    
    before(:each) do
      @page = Page.new(:name => 'Tutorials')
    end
    
    describe '#content' do
      it 'should be nil for a new page' do
        @page.content.should == nil
      end

      it "should return the content attribute of an existing page's latest version" do
        @page.version_attributes = { :content => 'Getting Started' }
        @page.save
        @page.content.should == 'Getting Started'
      end
      
      it 'should return the content attribute of the version number passed in' do
        @page.version_attributes = { :content => 'Getting Started' }
        @page.save
        # @page.version_attributes = { :content => "Getting Started\nAdvanced Guide" }
        # @page.save
        @page.versions.should == 'Getting Started'
      end
    end
  
    # describe "#content=" do
    #   it "should set the content of the page" do
    #     p = Page.new
    #     p.content = "Content for page"
    #     p.content.should == "Content for page"
    #   end
    #   
    #   it "should set the diff of the new html content and the old html content" do
    #     p = Page.new
    #     p.content = "Content for *page*"
    #     # p.content = [p.content, "Content for diff"].join("\n")
    #     p.content_diff.should == "\n<p>Content for <b>diff</b></p>"
    #   end
    # end
    #   
    # describe '#content_html' do
    #   it 'should fetch the html formatted content from the latest version' do
    #     @page.content_html.should == '<p>the content</p>'
    #   end
    #   
    #   it 'should return an empty string if #latest_version is nil' do
    #     Page.new.content_html.should == ''
    #   end
    # end
  end
  # 
  # describe '#name' do
  #   
  #   before(:each) do
  #     @existing_page = Page.new(:name => 'Existing name')
  #     @existing_page.stub!(:new_record?).and_return(false)
  #   end
  #   
  #   after(:each) do
  #     @existing_page = nil
  #   end
  #   
  #   it "should set a new record's name" do
  #     p = Page.new(:name => 'My name is Jonas')
  #     p.name.should == 'My name is Jonas'
  #   end
  #   
  #   it "should not allow an existing page's name to be overwritten" do
  #     old_name = @existing_page.name
  #     
  #     @existing_page.name = 'I want a new name'
  #     @existing_page.name.should == old_name
  #   end
  # end
  # 
  # describe 'slug characteristics' do
  #   it 'should be the page name' do
  #     @page = Page.new(:name => 'asuperinformativepage')
  #     @page.valid?
  #     @page.slug.should == 'asuperinformativepage'
  #   end
  # 
  #   it 'should be set before validations' do
  #     @page = Page.new(:name => 'asuperinformativepage')
  #     @page.slug.should be_nil
  #     @page.valid?
  #     @page.slug.should == 'asuperinformativepage'
  #   end
  #   
  #   it 'should be the page name downcased' do
  #     @page = Page.new(:name => 'ASuperInformativePage')
  #     @page.valid?
  #     @page.slug.should == 'asuperinformativepage'
  #   end
  #   
  #   it 'should be the page name with spaces dasherized' do
  #     @page = Page.new(:name => 'a super informative page')
  #     @page.valid?
  #     @page.slug.should == 'a-super-informative-page'
  #   end
  #   
  #   it 'should be the page name with non-word characters dasherized' do
  #     @page = Page.new(:name => 'a/super/informative/page')
  #     @page.valid?
  #     @page.slug.should == 'a-super-informative-page'
  #   end
  #   
  #   it 'should provide a custom finder' do
  #     Page.should respond_to(:by_slug)
  #   end
  # end
  # 
  # describe '#to_param' do
  #   it "should return the page's slug" do
  #     Page.new(:slug => 'a-slug').to_param.should == 'a-slug'
  #   end
  # end
  #   
  # describe '.versions' do
  #   it 'should not include any versions marked as spam' do
  #     @page = Page.create!(:name => 'A Page', :content => 'blah')
  #     @page.update_attributes(:content => 'spam', :spam => true)
  #     Page[@page.id].versions.length.should == 1
  #   end
  # end
  
end
