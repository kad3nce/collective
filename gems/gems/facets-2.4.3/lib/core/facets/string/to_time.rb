class String

  # Parse string to time.
  #
  #  CREDIT: Trans
  #
  # TODO: This requires the external time.rb lib. Should we do this?

  def to_time
    require 'time'
    Time.parse(self)
  end

end

