class Page < DataMapper::Base
  property :name, :string
  property :slug, :string
  property :versions_count, :integer, :default => 0
  has_many :versions
  before_save :build_new_version
  before_save :set_slug
  
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
  
  def select_version!(version_number)
    @selected_version = versions.detect { |version| version.number == version_number } || raise(NotFound)
    @content = @selected_version.content
  end
  
  def selected_version
    @selected_version || latest_version
  end
  
  def to_param
    slug
  end
  
  private
  def build_new_version
    # DataMapper not initializing versions_count with default value of zero. Bug?
    self.versions_count ||= 0
    
    self.versions_count += 1
    versions.build(:content => content, :number => versions_count)
  end
  
  def set_slug
    self.slug = URI.escape(name.downcase.gsub(/(\s|\/)/, '-'))
  end
end