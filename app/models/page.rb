require 'permalinker'

class Page < DataMapper::Base
  include Permalinker

  property :name,           :string 
  property :versions_count, :integer, :default => 0
  permalink_from :name
  has_many :versions
  before_save :build_new_version
  attr_writer :content
  
  def content
    @content ||= selected_version.try(:content) || ''
  end

  def content_html
    selected_version.try(:content_html) || ''
  end

  def latest_version
    versions.sort_by(&:number).last
  end
  
  def name=(new_name)
    @name = new_name if new_record?
  end
  
  def select_version!(version_number)
    @selected_version = versions.detect { |version| version.number == version_number } || raise(NotFound)
    @content = @selected_version.content
  end
  
  def selected_version
    @selected_version || latest_version
  end
  
private
  
  def build_new_version
    # DataMapper not initializing versions_count with default value of zero. Bug?
    self.versions_count ||= 0
    
    self.versions_count += 1
    versions.build(:content => content, :number => versions_count)
  end
  
end