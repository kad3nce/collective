require 'diff/lcs'

class Page < DataMapper::Base
  property :name, :string, :nullable => false
  attr_accessor :spam
  attr_accessor :spaminess
  attr_accessor :remote_ip
  attr_accessor :signature
  property :slug, :string, :nullable => false
  property :versions_count, :integer, :default => 0
  has_many :versions, :spam => false, :dependent => :destroy
  
  before_save :build_new_version
  before_validation :set_slug

  validates_uniqueness_of :slug
  validates_uniqueness_of :name

  def self.by_slug(slug)
    first(:slug => slug)
  end
  
  def content=(new_content)
    @content = new_content
  end
  
  def content
    @content ||= selected_version.try(:content) || ''
  end

  def content_html
    selected_version.try(:content_html) || ''
  end

  def diff(new_content)
    diff        = Diff::LCS.sdiff(content, new_content)
    all_changes = diff.reject { |diff| diff.unchanged? }
    additions   = all_changes.reject { |diff| diff.deleting? }
    additions.map { |diff| diff.to_a.last.last }.join
  end

  def latest_version
    Version.latest_version_for_page(self)
  end

  def name=(new_name)
    @name = new_name if new_record?
  end

  def select_version!(version_number=:latest)
    @selected_version = find_selected_version(version_number)
    self.content      = selected_version.try(:content)
    @selected_version
  end

  def selected_version
    @selected_version || latest_version
  end

  def self.slug_for(name)
    name = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', name).to_s
    name.gsub!(/\W+/, ' ') # non-words to space
    name.strip!
    name.downcase!
    name.gsub!(/\s+/, '-') # all spaces to dashes
    name
  end

  def to_param
    slug
  end

private

  def build_new_version
    # DataMapper not initializing versions_count with default value of zero. Bug?
    self.versions_count ||= 0
    self.versions_count  += 1 unless spam
    
    # Don't use #build as it is NULLifying the page_id field of this page's other versions
    versions.create(version_attributes)
  end
  
  def find_selected_version(version_number = :latest)
    if version_number == :latest
      latest_version
    else
      version_number = version_number.to_i
      versions.detect { |version| version.number == version_number }
    end
  end
  
  def version_attributes
    defaults = { 
      :content   => content, 
      :remote_ip => remote_ip, 
      :signature => signature
    }
    if spam
      defaults.update(
        :number    => versions_count.succ, 
        :spam      => true, 
        :spaminess => spaminess
      )
    else
      defaults.update(:number => versions_count)
    end
  end

  def set_slug
    self.slug = Page.slug_for(name) if new_record?
  end

end
