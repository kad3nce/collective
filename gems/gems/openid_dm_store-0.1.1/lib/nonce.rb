module OpenIDDataMapper

  class Nonce
    include DataMapper::Resource

    property :id,         Integer, :serial => true
    property :salt,       String,  :nullable => false
    property :server_url, String,  :nullable => false
    property :timestamp,  Integer, :nullable => false
  
    def self.default_storage_name
      "OpenIdNonce"
    end

  end
  
end