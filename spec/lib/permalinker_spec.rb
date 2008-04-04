require File.join( File.dirname(__FILE__), "..", "spec_helper" )
require File.join( File.dirname(__FILE__), "..", "..", "lib", "permalinker" )

# A class to play with
class Permalinked < DataMapper::Base
  include Permalinker
  
  ## Properties
  
  property :title, :string
  
  ## Plugins
  
  permalink_from :title
  
end

# Make sure the above class is in our db
DataMapper::Persistence.auto_migrate!

## The fun begins!

describe Permalinker do

  attr_accessor :model
  
  before(:each) do
    self.model = Permalinked.new(:title => "Some fancy title")
  end
  
  after(:each) do
    self.model = nil
  end

  it "should add a slug property" do
    model.should respond_to(:slug)
  end
  
  describe ".by_slug" do

    before(:each) do
      Permalinked.stub!(:find).and_raise(Exception)
    end
    
    it "should find a record by its slug" do
      Permalinked.should_receive(:find).and_return(model)
      Permalinked.by_slug("some-valid-permalink").should == model
    end

  end
  
  describe "#slug_suffix" do

    it "should be nil if the record does not have slug" do
      Permalinked.new(:slug => nil).slug_suffix.should be_nil
    end

    it "should be 0 if the slug does not have a suffix" do
      Permalinked.new(:slug => "some-fancy-title").slug_suffix.should be_zero
    end

    it "should be 1 if the slug has the suffix '-1'" do
      Permalinked.new(:slug => "some-fancy-title-1").slug_suffix.should == 1
    end

  end

  describe "#set_slug" do
    
    attr_accessor :same_slug, :also_same_slug
    
    before(:each) do
      Permalinked.stub!(:with_slug_like).and_return([])

      self.same_slug      = mock_model(Permalinked, :slug => "some-fancy-title",   :slug_suffix => 0)
      self.also_same_slug = mock_model(Permalinked, :slug => "some-fancy-title-1", :slug_suffix => 1)
    end
    
    after(:each) do
      self.same_slug      = nil
      self.also_same_slug = nil
    end
    
    it "should escape the specified property for use as a permalink" do
      model.valid?
      model.slug.should == 'some-fancy-title'
    end

    it "should ensure the permalink is unique when another record exists with the same slug"  do
      Permalinked.should_receive(:with_slug_like).and_return([same_slug])

      model.valid?
      model.slug.should == 'some-fancy-title-1'
    end

    it "should ensure the slug has a unique, larger suffix" do
      Permalinked.should_receive(:with_slug_like).and_return([same_slug, also_same_slug])

      model.valid?
      model.slug.should == 'some-fancy-title-2'
    end
    
  end

end
