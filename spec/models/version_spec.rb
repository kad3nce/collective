require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Version do
  
  describe '.new' do
    attr_accessor :page

    before(:each) do
      self.page = stub_everything('page')
    end

    after(:each) do
      self.page = nil
    end
    
    it 'should have a content field' do
      Version.new(:content => 'How to make Merb cook breakfast...').content.should == 'How to make Merb cook breakfast...'
    end

    it 'should have a content_html field' do
      Version.new(:content_html => '<p>How to make Merb cook breakfast...</p>').content_html.should == '<p>How to make Merb cook breakfast...</p>'
    end
    
    it 'should have a created_at field' do
      creation_time = Time.now
      Version.new(:created_at => creation_time).created_at.should == creation_time
    end

    it 'should have a number field' do
      Version.new(:number => 10).number.should == 10
    end

    it 'should belong to a page' do
      Version.new(:page => page).page.should == page
    end
  end

  describe '#populate_html_content' do
    
    attr_accessor :version
    
    before(:each) do
      Version.publicize_methods do
        self.version = Version.new(:content => 'How to make [[Merb]] cook breakfast')
        version.populate_content_html
      end
    end
    
    after(:each) do
      self.version = nil
    end
    
    it 'should render content to HTML' do
      version.content_html.should match(/^<p>How to make/)
    end
    
    it 'should convert double-bracketed phrases to internal links' do
      version.content_html.should match(/<a href="\/pages\/merb">Merb<\/a>/)
    end
  end

  describe '.most_recent_unmoderated' do
    attr_accessor :versions
    
    before(:each) do
      self.versions = []
    end
    
    after(:each) do
      self.versions = nil
    end
    
    it 'should find the most recent Versions' do
      Version.should_receive(:all).and_return(versions)
      Version.most_recent_unmoderated.should == versions
    end
  end

  describe '#spam_or_ham' do
    it "should be 'spam' if the record is flagged as spam" do
      Version.new(:spam => true).spam_or_ham.should == 'spam'
    end
    
    it "should be 'ham' if the record is not flagged as spam" do
      Version.new(:spam => false).spam_or_ham.should == 'ham'
    end
  end

end