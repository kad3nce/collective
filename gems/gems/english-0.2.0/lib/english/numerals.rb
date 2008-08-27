# TITLE
#
#   English Numerals
#
# SUMMARY:
#
#   Convert integers into english word form.
#
# AUTHORS:
#
#   Glenn P. Parker

module English #:nodoc:

module Numerals

  Ones = %w[ zero one two three four five six seven eight nine ]
  Teen = %w[ ten eleven twelve thirteen fourteen fifteen
            sixteen seventeen eighteen nineteen ]
  Tens = %w[ zero ten twenty thirty forty fifty
            sixty seventy eighty ninety ]
  Mega = %w[ none thousand million billion ]

  # Convert an integer to the english spelling of that number.

  def name(integer)
    places = integer.to_i.to_s.split(//).collect{|s| s.to_i}.reverse
    name = []
    ((places.length + 2) / 3).times do |p|
      strings = Numerals.trio(places[p * 3, 3])
      name.push(Mega[p]) if strings.length > 0 and p > 0
      name += strings
    end
    name.push(Ones[0]) unless name.length > 0
    name.reverse.join(" ")
  end

  private

  def self.trio(places)
    strings = []
    if places[1] == 1
      strings.push(Teen[places[0]])
    elsif places[1] and places[1] > 0
      strings.push(places[0] == 0 ? Tens[places[1]] :
                  "#{Tens[places[1]]}-#{Ones[places[0]]}")
    elsif places[0] > 0
      strings.push(Ones[places[0]])
    end
    if places[2] and places[2] > 0
      strings.push("hundred", Ones[places[2]])
    end
    strings
  end

end

end # module English

#

class Integer #:nodoc:

  #
  #   10.english #=> 'ten'

  def english
    English::Numerals.name(self)
  end

end
