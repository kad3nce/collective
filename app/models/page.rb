class Page
  include DataMapper::Resource
  
  property :id,   Integer, :serial => true
  property :name, String,  :nullable => false
  property :slug, String,  :nullable => false

  has n, :versions, :spam => false

  # def versions
  #   versions_excluding_spam = versions_including_spam.reject { |version| version.spam }
  #   versions_including_spam_association.replace(versions_including_spam.all(:spam => false).to_a)
  # end
  
  before :destroy do
    self.versions.each { |v| v.destroy }
  end

  validates_is_unique :slug
  validates_is_unique :name

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
  
  def find_version(version_number)
    if version_number == :latest
      versions.last
    else
      versions.at(version_number.to_i-1)
    end
  end
  
  def name=(new_name)
    if new_record?
      attribute_set(:name, new_name)
      self.slug = Page.slug_for(new_name)
    end
  end

  def to_param
    slug
  end

end
