class Version < DataMapper::Base
  property :content,      :text
  property :content_html, :text
  property :created_at,   :datetime
  property :moderated,    :boolean, :default => false
  property :number,       :integer
  property :spam,         :boolean, :default => false
  property :spaminess,    :float,   :default => 0
  property :signature,    :string
  
  belongs_to :page
  
  before_save :populate_content_html

  validates_presence_of :content

  def spam_or_ham
    spam? ? 'spam' : 'ham'
  end
  
  def self.most_recent_unmoderated(max=100)
    all(:moderated => false, :limit => max, :order => 'created_at DESC')
  end
  
  def self.latest_version_for_page(page)
    first(:page_id => page.id, :order => 'number DESC', :spam => false)
  end
  
  def self.create_spam(page_name, options={})
    create(
      options.update(
        :spam    => true, 
        :page_id => -1, 
        :content => [options[:content], page_name].join(':')
      )
    )
  end
  
  def self.recent(number = 10)
    all(:limit => number, :order => 'id DESC', :spam => false)
  end

  # Generate the diff between the version and another
  # send by params
  # You can define the format, by default is unified
  # if other_version is nil, return ""
  def diff(other_version, format=:unified)
    Diff.cs_diff(content_html, other_version.content_html, :unified, 0) unless other_version.nil?
  end

  # Get the previous version for this page
  # If there are no version previous, return null
  def previous
    page.versions.find do |version|
      version.number == (self.number - 1)
    end
  end
  
private
  def linkify_bracketed_phrases(string)
    string.gsub(/\[\[([^\]]+)\]\]/) { "<a href=\"/pages/#{Page.slug_for($1.strip)}\">#{$1.strip}</a>" }
  end

  def populate_content_html
    content_with_internal_links = linkify_bracketed_phrases(content)
    self.content_html = RedCloth.new(content_with_internal_links).to_html
  end
end
