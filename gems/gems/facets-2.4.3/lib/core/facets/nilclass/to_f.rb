unless (RUBY_VERSION[0,3] == '1.9')

  class NilClass

    # Allows <tt>nil</tt> to respond to #to_f.
    # Always returns <tt>0</tt>.
    #
    #   nil.to_f   #=> 0.0
    #
    #   CREDIT: Matz

    def to_f; 0.0; end

  end

end

