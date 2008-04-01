class Page < DataMapper::Base
  property :name, :string
  property :slug, :string
  has_many :versions
  before_save :build_new_version
  before_save :set_slug
  attr_writer :content

  # ============================================
  # = TODO: This is a brainbuster; refactor it =
  # ============================================
  def content
    @content ||= latest_version.try(:content) || ''
  end

  def content_html
    latest_version.try(:content_html) || ''
  end

  # ==================
  # = TODO: Optimize =
  # ==================
  def latest_version
    versions.sort_by(&:created_at).last
  end
  
  def to_param
    slug
  end
  
  private
  def build_new_version
    versions.build(:content => content)
  end
  
  def set_slug
    self.slug = URI.escape(name.downcase.gsub(' ', '-')).gsub('/', '%2F')
  end
end