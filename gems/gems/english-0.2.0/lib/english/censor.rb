# = TITLE:
#   Censor
#
# = SYNOPIS:
#   Very basic extension to string for weeding out text.
#
# AUTHORS:
#    - George Moschovitis
#    - Trans
#
# TODO:
#   - Deprecate in favor or, or rewrite to use, textfilter.rb ?

class String #:nodoc:

  # Apply a set of rules (regular expression matches) to the string.
  #
  # The rules must be applied in order! So we cannot use a
  # hash because the ordering is not guaranteed! we use an
  # array instead.

  def censor(rules)
    raise ArgumentError.new('rules parameter is nil') unless rules  # gmosx: helps to find bugs
    s = dup
    rules.each do |match,edit|
      s.gsub!(match,edit)
    end
    return s
  end

  alias_method :rewrite, :censor

  # Make sure the string passes a collection of censorship rules
  # defined with reqular expressions.

  def censored?(rules)
    for r in rules
      return true if self =~ r
    end
    return false
  end

  # Filters out words from a string based on block test.
  #
  #   "a string".word_filter { |word| word =~ /^a/ }  #=> "string"
  #
  def censor_words( &blk )
    s = self.dup
    s.censor_words!( &blk )
  end

  alias_method :word_filter, :censor_words

  # In place version of #word_filter.
  #
  #   "a string".word_filter { |word| ... }
  #
  # TODO: Surely this can be written better.

  def censor_words! #:yield:
    rest_of_string = self
    wordfind = /(\w+)/
    offset = 0
    while wmatch = wordfind.match(rest_of_string)
      word = wmatch[0]
      range = offset+wmatch.begin(0) ... offset+wmatch.end(0)
      rest_of_string = wmatch.post_match
      self[range] = yield( word ).to_s
      offset = self.length - rest_of_string.length
    end
    self
  end

  alias_method :word_filter!, :censor_words!

end
