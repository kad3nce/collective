# = TITLE:
#   String Jumble
#
# = SYNOPSIS:
#   Means of scrambling and distorting text.
#
# = AUTHOR:
#   - Trans

module English #:nodoc:

  module Jumble

    extend self

    # Jumble string.

    def jumble(string)
      j = ''
      string.split(//).each_with_index{ |c,i| j << ( i % 2 == 0 ? c.downcase : c.upcase ) }
      j
    end

  end

end

# Extensions to String.

class String #:nodoc:

  # Jumble string.

  def jumble
    English::Jumble.jumble(self)
  end

  # In-place version of #jumble.

  def jumble!
    replace(jumble)
  end

end
