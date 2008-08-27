class Time
  public :to_date
  public :to_datetime
end

# THIS IS ALREADY IN RUBY, WHY WAS IT THOUGHT NOT TO BE?

=begin
unless (RUBY_VERSION[0,3] == '1.9')

  class Time

    # Convert a Time to a Date. Time is a superset of Date.
    # It is the year, month and day that are carried over.

    def to_date
      require 'date' # just in case
      jd = Date.__send__(:civil_to_jd, year, mon, mday, Date::ITALY)
      Date.new!(Date.__send__(:jd_to_ajd, jd, 0, 0), 0, Date::ITALY)
    end

  end

end
=end

