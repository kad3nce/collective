class Page < DataMapper::Base
  property :name,           :string,  :nullable => false
  property :slug,           :string,  :nullable => false
  property :versions_count, :integer, :default => 0
  
  attr_accessor :version_attributes
  
  has_many :versions, :spam => false, :dependent => :destroy
  
  before_save :build_new_version
  before_validation :set_slug

  validates_uniqueness_of :slug
  validates_uniqueness_of :name

  def self.by_slug(slug)
    first(:slug => slug)
  end
  
  def self.slug_for(name)
    name = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', name).to_s
    name.gsub!(/\W+/, ' ') # non-words to space
    name.strip!
    name.downcase!
    name.gsub!(/\s+/, '-') # all spaces to dashes
    name
  end
  
  def content(version = :latest)
    find_version(version).try(:content)
  end
  
  def content_html(version = :latest)
    find_version(version).try(:content_html)
  end

  def find_version(version_number)
    if version_number == :latest
      versions.last
    else
      versions.detect { |version| version.number == version_number.to_i }
    end
  end
  
  def name=(new_name)
    @name = new_name if new_record?
  end

  def to_param
    slug
  end

private

  def build_new_version
    # DataMapper not initializing versions_count with default value of zero. Bug?
    self.versions_count ||= 0
    self.versions_count  += 1 unless version_attributes[:spam]
    
    versions.create(version_attributes.merge!(:number => versions_count))
  end
  
  # def version_attributes
  #   defaults = { 
  #     :content   => content, 
  #     :remote_ip => remote_ip, 
  #     :signature => signature
  #   }
  #   if spam
  #     defaults.update(
  #       :number    => versions_count.succ, 
  #       :spam      => true, 
  #       :spaminess => spaminess
  #     )
  #   else
  #     defaults.update(:number => versions_count)
  #   end
  # end

  def set_slug
    self.slug = Page.slug_for(name) if new_record?
  end

end
