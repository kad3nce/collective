# = TITLE:
#   Soundex
#
# = SYNOPSIS:
#   Ruby implementation of the Soundex algorithm,
#   as described by Knuth in volume 3 of The Art
#   of Computer Programming.
#
# = AUTHOR:
#   Michael Neumann (neumann@s-direktnet.de)

module English # :nodoc:

  # Ruby implementation of the Soundex algorithm,
  # as described by Knuth in volume 3 of The Art
  # of Computer Programming.

  module Soundex

    module_function

    # Returns nil if the value couldn't be calculated b/c of
    # empty-string or invalid character.
    #
    #   "Ruby".soundex  #=> "R100"

    def soundex(str)
      return nil if str.empty?

      str = str.upcase
      last_code = soundex_code(str[0,1])
      soundex_code = str[0,1]

      for index in 1...(str.size) do
        return soundex_code if soundex_code.size == 4

        code = soundex_code(str[index,1])

        if code == "0" then
          last_code = nil
        elsif code == nil then
          return nil
        elsif code != last_code then
          soundex_code += code
          last_code = code
        end
      end

      return soundex_code + "000"[0,4-soundex_code.size]
    end

    # Support function for String#soundex.
    # Returns code for a single character.

    def soundex_code(char)
      char.tr! "AEIOUYWHBPFVCSKGJQXZDTLMNR", "00000000111122222222334556"
    end

  end # module Soundex

end # module English


class String

  def soundex
    English::Soundex.soundex(self)
  end

end
