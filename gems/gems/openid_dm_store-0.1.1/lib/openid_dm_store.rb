require 'association'
require 'nonce'
require 'openid/store/interface'

module OpenIDDataMapper
  
  class DataMapperStore < OpenID::Store::Interface
    def store_association(server_url, assoc)
      remove_association(server_url, assoc.handle)    
      Association.create(:server_url => server_url,
                         :handle     => assoc.handle,
                         :secret     => assoc.secret,
                         :issued     => assoc.issued,
                         :lifetime   => assoc.lifetime,
                         :assoc_type => assoc.assoc_type)
    end

    def get_association(server_url, handle=nil)
      assocs = if handle.blank?
          # Association.find_all_by_server_url(server_url)
          Association.all(:server_url => server_url)
        else
          # Association.find_all_by_server_url_and_handle(server_url, handle)
          Association.all(:server_url => server_url, :handle => handle)
        end

      # assocs.reverse.each do |assoc|
      assocs.to_a.reverse.each do |assoc|
        a = assoc.from_record    
        if a.expires_in == 0
          # assoc.destroy
          assoc.destroy!
        else
          return a
        end
      end if assocs.any?

      return nil
    end

    def remove_association(server_url, handle)
      # Association.delete_all(['server_url = ? AND handle = ?', server_url, handle]) > 0
      Association.all(:server_url => server_url, :handle => handle).destroy!
    end

    def use_nonce(server_url, timestamp, salt)
      # return false if Nonce.find_by_server_url_and_timestamp_and_salt(server_url, timestamp, salt)
      return false if Nonce.first(:server_url => server_url, :timestamp => timestamp, :salt => salt)
      return false if (timestamp - Time.now.to_i).abs > OpenID::Nonce.skew
      Nonce.create(:server_url => server_url, :timestamp => timestamp, :salt => salt)
      return true
    end

    def cleanup_nonces
      now = Time.now.to_i
      # Nonce.delete_all(["timestamp > ? OR timestamp < ?", now + OpenID::Nonce.skew, now - OpenID::Nonce.skew])
      Nonce.all(:conditions => ["timestamp > ? OR timestamp < ?", now + OpenID::Nonce.skew, now - OpenID::Nonce.skew]).destroy!
    end

    def cleanup_associations
      now = Time.now.to_i
      # Association.delete_all(['issued + lifetime > ?',now])
      Association.all(:conditions => ['issued + lifetime > ?', now]).destroy!
    end

  end
  
end
