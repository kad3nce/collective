require File.join(File.dirname(__FILE__), '..',  'spec_helper')

describe Page do
  
  describe 'associations' do
    before(:each) do
      @page = Page.gen(:page_with_several_versions)
    end
    
    after(:each) do
      Page.auto_migrate!
      Version.auto_migrate!
    end
    
    it 'should destroy all associated versions when destroyed' do
      Version.all.length.should == 7
      @page.destroy
      Version.all.length.should == 0
    end
  end
  
  describe '.new' do
    it 'should have a name property' do
      Page.new(:name => 'A super informative page').name.should == 'A super informative page'
    end

    it 'should have a slug property' do
      Page.new(:slug => 'a-super-informative-page').slug.should == 'a-super-informative-page'
    end

    it 'should have many versions' do
      Page.new.versions.should == []
    end
  end

  describe '#find_version' do
    before(:each) do
      @page = Page.new(:name => 'Tutorials')
      @page.versions.build(:content => 'Getting started...')
      @page.save!
      @page.versions.build(:content => '...with Collective')
      @page.save!
    end
    
    after(:each) do
      Page.auto_migrate!
      Version.auto_migrate!
    end
    
    it 'should return the version number passed' do
      @page.find_version(1).content.should == 'Getting started...'
    end
    
    it 'should accept :latest as an argument and return the latest version' do
      @page.find_version(:latest).content.should == '...with Collective'
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
    after(:each) do
      Page.auto_migrate!
      Version.auto_migrate!
    end
    
    it 'should not include any versions marked as spam' do
      @page = Page.create!(:name => 'A Page')
      @version = Version.new(:content => 'Free Viagra!', :spam => true)
      @page.versions << @version
      @version.save
      @page.save
      Page.get!(@page.id).versions.length.should == 0
    end
  end
  
end
