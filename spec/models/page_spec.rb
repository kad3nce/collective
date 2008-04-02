require File.join(File.dirname(__FILE__), '..',  'spec_helper')

describe Page do
  it 'should have a name property' do
    Page.new(:name => 'A super informative page').name.should == 'A super informative page'
  end

  it 'should have a slug property' do
    Page.new(:slug => 'a-super-informative-page').slug.should == 'a-super-informative-page'
  end

  it 'should have many versions' do
    Page.new.versions.should be_an_instance_of(DataMapper::Associations::HasManyAssociation::Set)
  end

  it 'should have a versions_count property' do
    Page.new(:versions_count => 10).versions_count.should == 10
  end

  it 'should create a new version when saving' do
    page = Page.create(:content => 'the body of the page', :name => 'a new page')
    first_version = page.latest_version
    page.save
    page.latest_version.should_not == first_version
  end

  describe '#latest_version' do
    it 'should fetch the latest version of the page' do
      page = Page.new
      page.versions << old_version = Version.new(:number => 1)
      page.versions << latest_version = Version.new(:number => 2)
      page.latest_version.should == latest_version
    end
  end

  describe do
    before(:each) do
      @page = Page.new
      @page.versions << Version.new(:content => 'the content', :content_html => '<p>the content</p>')
    end

    describe '#content' do
      it 'should fetch the content from the latest version' do
        @page.content.should == 'the content'
      end

      it 'should return an empty string if #latest_version is nil' do
        Page.new.content.should == ''
      end
    end

    describe '#content=' do
      it 'should change the return value of #content' do
        page = Page.new
        lambda {
          page.content = 'Some new content'
          }.should change(page, :content)
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
  
  describe '#select_version!' do
    before(:each) do
      raise(@page.inspect) if @page
      @page = Page.new
      @page.versions << first_version = Version.new(:content => 'Initial Content', :content_html => '<p>Initial Content</p>', :number => 1)
      @page.versions << second_version = Version.new(:content => 'Updated Content', :content_html => '<p>Updated Content</p>', :number => 2)
    end
    
    it 'should change the return value of #content when asking for an older version' do
      lambda {
        @page.select_version!(1)
      }.should change(@page, :content)
    end
    
    it 'should change the return value of #content_html when asking for an older version' do
      lambda {
        @page.select_version!(1)
      }.should change(@page, :content_html)
    end
    
    it 'should raise Page::VersionNotFound when asked for a non-existent version' do
      lambda { @page.select_version!(2000) }.should raise_error(Page::VersionNotFound)
    end
  end
  
  
  describe '#to_param' do
    it "should return the page's slug" do
      Page.new(:slug => 'a-super-informative-page').to_param.should == 'a-super-informative-page'
    end
  end

  describe '#slug' do
    it 'should be the page name' do
      Page.create!(:name => 'asuperinformativepage').slug.should == 'asuperinformativepage'
    end

    it 'should be the page name downcased' do
      Page.create!(:name => 'ASuperInformativePage').slug.should == 'asuperinformativepage'
    end

    it 'should be the page name with spaces dasherized' do
      Page.create!(:name => 'a super informative page').slug.should == 'a-super-informative-page'
    end

    it 'should be the page name with forward slashes escaped' do
      Page.create!(:name => 'a/super/informative/page').slug.should == 'a%2Fsuper%2Finformative%2Fpage'
    end

    it 'should be the page name with any other non URL-friendly characters escaped' do
      Page.create!(:name => '\2007\11\15').slug.should == '%5C2007%5C11%5C15'
    end
  end
  
end