require 'data_mapper'

class DataMapper::Base
  # Provides an easy-to-use interface for testing for errors on a specific 
  # attribute.
  # 
  # ==== Arguments
  # attribute, <Symbol>:: the attribute to check for errors on
  # 
  # ==== Example
  #   Person.new(attributes).should have(2).errors_on(:name)
  def errors_on(attribute)
    valid?
    [errors.on(attribute)].flatten.compact
  end
  
  # Alias for +errors_on+
  alias_method :error_on, :errors_on
end