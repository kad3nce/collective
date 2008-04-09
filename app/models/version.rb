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
  
  after_save  :update_as_spam_or_ham

  def self.most_recent_unmoderated(max=100)
    all(:moderated => false, :limit => max, :order => 'created_at DESC')
  end
  
private
  def populate_content_html
    self.content_html = RedCloth.new(content).to_html
  end
  
  def update_as_spam_or_ham
    # FIXME Refactoring opportunity:
    # This sort of logic should be shoved inside of Viking. If models that are 
    # protected using Viking have a certain assumed API, we can keep any sort 
    # of logic like the below where it belongs: in Viking.
    if spam?
      DEFENSIO_GATEWAY.mark_as_ham(:signatures => signature)
    else
      DEFENSIO_GATEWAY.mark_as_spam(:signatures => signature)
    end
  end
end
