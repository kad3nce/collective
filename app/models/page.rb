class Page < DataMapper::Base
  property :name, :string, :nullable => false
  attr_accessor :spam
  attr_accessor :spaminess
  attr_accessor :remote_ip
  attr_accessor :signature
  property :slug, :string, :nullable => false
  property :versions_count, :integer, :default => 0
  # ==============================================================
  # = TODO: Remove this hack once DataMapper supports with_scope =
  # ==============================================================
  has_many :versions_with_spam, :class => 'Version'
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

  def content_additions(new_content)
    diff = Diff::LCS.sdiff(content, new_content)
    all_changes = diff.reject { |diff| diff.unchanged? }
    additions = all_changes.reject { |diff| diff.deleting? }
    additions.map { |diff| diff.to_a.last.last }.join
  end

  def latest_version
    versions.sort_by(&:number).last
  end

  def name=(new_name)
    @name = new_name if new_record?
  end

  def select_version!(version_number)
    if @selected_version = versions.detect { |version| version.number == version_number }
      @content = @selected_version.content
    end
    @selected_version
  end

  def selected_version
    @selected_version || latest_version
  end

  def to_param
    slug
  end

  # ==============================================================
  # = TODO: Remove this hack once DataMapper supports with_scope =
  # ==============================================================
  def versions
    versions_with_spam.set(versions_with_spam.reject { |version| version.spam })
    versions_with_spam
  end
  
private

  def build_new_version
    # DataMapper not initializing versions_count with default value of zero. Bug?
    self.versions_count ||= 0

    version_attributes = { :content => @content, :remote_ip => @remote_ip, :signature => @signature }

    if(spam)
      versions.create(version_attributes.merge(:number => versions_count + 1, :spam => true, :spaminess => @spaminess))
    else
      self.versions_count += 1
      # Don't use #build as it is NULLifying the page_id field of this page's other versions
      versions.create(version_attributes.merge(:number => versions_count))
    end
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