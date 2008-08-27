unless (RUBY_VERSION[0,3] == '1.9')

  class String

    # Returns an array of characters.
    #
    #   "abc".chars  #=> ["a","b","c"]

    def chars
      self.split(//)
    end

  end

end

