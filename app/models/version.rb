class Version < DataMapper::Base
  
  ## Properties
  
  property :content,      :text
  property :content_html, :text
  property :created_at,   :datetime
  property :number,       :integer
  
  ## Associations
  
  belongs_to :page
  
  ## Call-backs
  
  before_save :populate_content_html
  
private

  def populate_content_html
    self.content_html = RedCloth.new(content).to_html
  end

end