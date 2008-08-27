unless (RUBY_VERSION[0,3] == '1.9')

  class Integer

    # Returns true if this integer is odd, false otherwise.
    #
    #   2.odd?            #=> false
    #   3.odd?            #=> true
    #
    #   -99.odd?          # -> true
    #   -98.odd?          # -> false
    #
    #   CREDIT: Gavin Sinclair

    def odd?
      self % 2 == 1
    end

    # Returns true if this integer is even, false otherwise.
    #
    #   2.even?  #=> true
    #   3.even?  #=> false
    #
    #   CREDIT: Gavin Sinclair

    def even?
      self % 2 == 0
    end

  end

end

