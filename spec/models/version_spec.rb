require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Version do
  before(:each) do
    @page = stub_everything('page')
  end
  
  it 'should have a content field' do
    Version.new(:content => 'How to make Merb cook breakfast...').content.should == 'How to make Merb cook breakfast...'
  end
  
  it 'should have a content_html field' do
    Version.new(:content_html => '<p>How to make Merb cook breakfast...</p>').content_html.should == '<p>How to make Merb cook breakfast...</p>'
  end

  it 'should have a created_at field' do
    creation_time = Time::now
    Version.new(:created_at => creation_time).created_at.should == creation_time
  end

  it 'should belong to a page' do
    Version.new(:page => @page).page.should == @page
  end
  
  it 'should populate content_html before saving by converting its content attribute to html' do
    Version.create!(:content => 'How to make Merb cook breakfast...').content_html.should == '<p>How to make Merb cook breakfast&#8230;</p>'
  end
end