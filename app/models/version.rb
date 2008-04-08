class Version < DataMapper::Base
  property :content,      :text
  property :content_html, :text
  property :created_at,   :datetime
  property :number,       :integer
  property :spam,         :boolean, :default => false
  property :spaminess,    :float, :default => 0
  
  belongs_to :page
  
  before_save :populate_content_html
  
private
  def populate_content_html
    self.content_html = RedCloth.new(content).to_html
  end
end
