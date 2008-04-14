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
  
  # after_save  :update_as_spam_or_ham

  def spam_or_ham
    spam? ? 'spam' : 'ham'
  end

  def self.most_recent_unmoderated(max=100)
    all(:moderated => false, :limit => max, :order => 'created_at DESC')
  end
  
  def self.latest_version_for_page(page)
    first(:page_id => page.id, :order => 'number DESC', :spam => false)
  end
  
private
  def populate_content_html
    self.content_html = RedCloth.new(content).to_html
  end
end
