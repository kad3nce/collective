# = title:
#   Metaphone
#
# = synopsis:
#   An implementation of the Metaphone phonetic coding system in Ruby.
#
# = author:
#   Paul Battley (pbattley@gmail.com)

module English # :nodoc:

  #   Metaphone encodes names into a phonetic form such that similar-sounding names
  #   have the same or similar Metaphone encodings.
  #
  #   The original system was described by Lawrence Philips in Computer Language
  #   Vol. 7 No. 12, December 1990, pp 39-43.
  #
  #   As there are multiple implementations of Metaphone, each with their own
  #   quirks, I have based this on my interpretation of the algorithm specification.
  #   Even LP's original BASIC implementation appears to contain bugs (specifically
  #   with the handling of CC and MB), when compared to his explanation of the
  #   algorithm.
  #
  #   I have also compared this implementation with that found in PHP's standard
  #   library, which appears to mimic the behaviour of LP's original BASIC
  #   implementation. For compatibility, these rules can also be used by passing
  #   :alternate=>true to the methods.

  module Metaphone

    extend self

    # Metaphone rules.  These are simply applied in order.

    RULES = [
      # Regexp, replacement
      [ /([bcdfhjklmnpqrstvwxyz])\1+/,
                          '\1' ],  # Remove doubled consonants except g.
                                  # [PHP] remove c from regexp.
      [ /^ae/,            'E' ],
      [ /^[gkp]n/,        'N' ],
      [ /^wr/,            'R' ],
      [ /^x/,             'S' ],
      [ /^wh/,            'W' ],
      [ /mb$/,            'M' ],  # [PHP] remove $ from regexp.
      [ /(?!^)sch/,      'SK' ],
      [ /th/,             '0' ],
      [ /t?ch|sh/,        'X' ],
      [ /c(?=ia)/,        'X' ],
      [ /[st](?=i[ao])/,  'X' ],
      [ /s?c(?=[iey])/,   'S' ],
      [ /[cq]/,           'K' ],
      [ /dg(?=[iey])/,    'J' ],
      [ /d/,              'T' ],
      [ /g(?=h[^aeiou])/, ''  ],
      [ /gn(ed)?/,        'N' ],
      [ /([^g]|^)g(?=[iey])/,
                        '\1J' ],
      [ /g+/,             'K' ],
      [ /ph/,             'F' ],
      [ /([aeiou])h(?=\b|[^aeiou])/,
                          '\1' ],
      [ /[wy](?![aeiou])/, '' ],
      [ /z/,              'S' ],
      [ /v/,              'F' ],
      [ /(?!^)[aeiou]+/,  ''  ],
    ]

    # The rules for the 'buggy' alternate implementation used by PHP etc.

    LP_RULES = RULES.dup
    LP_RULES[0] = [ /([bdfhjklmnpqrstvwxyz])\1+/, '\1' ]
    LP_RULES[6] = [ /mb/, 'M' ]

    # Returns the Metaphone representation of a string. If the string contains
    # multiple words, each word in turn is converted into its Metaphone
    # representation. Note that only the letters A-Z are supported, so any
    # language-specific processing should be done beforehand.
    #
    # If +alt+ is set to true, alternate 'buggy' rules are used.

    def metaphone(str, alt=nil)
      return str.strip.split(/\s+/).map{ |w| metaphone_word(w, alt) }.join(' ')
    end

  private

    def metaphone_word(w, alt=nil)
      # Normalise case and remove non-ASCII
      s = w.downcase.gsub(/[^a-z]/, '')
      # Apply the Metaphone rules
      rules = alt ? LP_RULES : RULES
      rules.each { |rx, rep| s.gsub!(rx, rep) }
      return s.upcase
    end

  end

end


class String #:nodoc:

  # Returns the Metaphone representation of a string.

  def metaphone
    English::Metaphone.metaphone(self)
  end

end
