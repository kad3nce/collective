class Page < DataMapper::Base
  property :name, :string, :nullable => false
  property :slug, :string, :nullable => false
  property :versions_count, :integer, :default => 0
  has_many :versions
  before_save :build_new_version
  before_validation :set_slug

  validates_uniqueness_of :slug
  validates_uniqueness_of :name

  def self.by_slug(slug)
    first(:slug => slug)
  end

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
    @selected_version = versions.detect { |version| version.number == version_number } || debugger
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
    # Don't use #build as it is NULLifying the page_id field of this page's other versions
    versions.create(:content => content, :number => versions_count)
  end

  def escape_slug(string)
    string = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', string).to_s
    string.gsub!(/\W+/, ' ') # non-words to space
    string.strip!
    string.downcase!
    string.gsub!(/\s+/, '-') # all spaces to dashes
    string
  end

  def set_slug
    self.slug = escape_slug(name) if new_record?
  end

end