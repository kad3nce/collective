class User
  include DataMapper::Resource

  property :id,         Integer, :serial   => true
  property :name,       String,  :nullable => false
  property :openid_url, String,  :nullable => false
  property :trusted,    Boolean, :default  => false

  before :valid?, :populate_name
  
  def openid_url=(new_openid_url)
    attribute_set(:openid_url, new_openid_url) if new_record?
  end
  
private

  def populate_name
    self.name = openid_url if name.blank?
  end

end
