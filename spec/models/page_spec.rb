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
      Page.new.versions.should == []
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
        @page.save!
        @page.content.should == 'Getting Started'
      end
      
      it 'should return the content attribute of the version number passed in' do
        @page.version_attributes = { :content => 'Getting Started' }
        @page.save!
        @page.version_attributes = { :content => "Getting Started\n\nAdvanced Guide" }
        @page.save!
        @page.content(1).should == 'Getting Started'
        @page.content(2).should == "Getting Started\n\nAdvanced Guide"
      end
    end
  
    describe '#content_html' do
      it 'should be nil for a new page' do
        @page.content.should == nil
      end
    
      it "should return the content_html attribute of an existing page's latest version" do
        @page.version_attributes = { :content => 'Getting Started' }
        @page.save!
        @page.content_html.should == '<p>Getting Started</p>'
      end
      
      it 'should return the content_html attribute of the version number passed in' do
        @page.version_attributes = { :content => 'Getting Started' }
        @page.save!
        @page.version_attributes = { :content => "Getting Started\n\nAdvanced Guide" }
        @page.save!
        @page.content_html(1).should == '<p>Getting Started</p>'
        @page.content_html(2).should == "<p>Getting Started</p>\n\n\n\t<p>Advanced Guide</p>"
      end
    end
  end
  
  describe '#find_version' do
    before(:each) do
      @page = Page.create!(:name => 'Tutorials', :version_attributes => { :content => 'Getting started' })
      @page.save!
      @page.version_attributes = { :content => 'Beginning' }
      @page.save!
    end
    
    it 'should return the version number passed' do
      @page.find_version(1).content.should == 'Getting started'
    end
    
    it 'should accept :latest as an argument and return the latest version' do
      @page.find_version(:latest).content.should == 'Beginning'
    end
    
    it "should return nil if the version number doesn't exist" do
      @page.find_version(100).should == nil
    end
  end
  
  describe '#name' do
    
    before(:each) do
      @existing_page = Page.new(:name => 'Existing name')
      @existing_page.stub!(:new_record?).and_return(false)
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
  
  describe 'slug characteristics' do
    it 'should be set with the page name' do
      @page = Page.new(:name => 'asuperinformativepage')
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
    
    it 'should provide a custom finder' do
      Page.should respond_to(:by_slug)
    end
  end
  
  describe '#to_param' do
    it "should return the page's slug" do
      Page.new(:slug => 'a-slug').to_param.should == 'a-slug'
    end
  end
    
  describe '.versions' do
    it 'should not include any versions marked as spam' do
      @page = Page.create!(:name => 'A Page', :version_attributes => { :content => 'blah', :spam => true })
      Page[@page.id].versions.length.should == 0
    end
  end
  
end
