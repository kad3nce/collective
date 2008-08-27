unless (RUBY_VERSION[0,3] == '1.9')

  class Time

    # To be able to keep Dates and Times interchangeable
    # on conversions.

    def to_time
      getlocal 
    end

  end

end

