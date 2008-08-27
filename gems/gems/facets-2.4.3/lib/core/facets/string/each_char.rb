unless (RUBY_VERSION[0,3] == '1.9')

  class String

    # Iterates through each character. This is a little faster than
    # using #chars b/c it does not create the intermediate array.
    #
    #    a = ''
    #   "HELLO".each_character{ |c| a << #{c.downcase} }
    #    a  #=> 'hello'

    def each_char  # :yield:
      size.times do |i|
        yield(self[i,1])
      end
    end

  end

end
