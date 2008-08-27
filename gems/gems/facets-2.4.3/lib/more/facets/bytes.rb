# = Bytes
#
# WARNING: Use Rich Units package for future compatibilty!
#
# == Synopisis
#
# Additional methods for Numeric class to make working with
# bits and bytes easier.
#
# Additional methods for Numeric class to make working with
# bits and bytes easier. Bits are used as the base value and
# these methods can be used to convert between different
# magnitudes.
#
#   1.byte               #=> 8
#   2.bytes              #=> 16
#   1.kilobit            #=> 1024
#   1.kilobyte           #=> 8192
#
# Use the in_* methods to perform the inverse operations.
#
#   8192.in_kilobytes    #=> 1
#   1024.in_kilobits     #=> 1
#
# == History
#
# Special thanks to Richard Kilmer for the orignal work.
# This library is based on the original library bytes.rb
# Copyright (c) 2004 by Rich Kilmer.
#
# Also thanks to Alexander Kellett for suggesting it be
# included in Facets.
#
# == Authors
#
# * Rich Kilmer
# * Thomas Sawyer
#
# == NOTES
#
# This library is not compatible with STICK's units.rb (an spin-off
# of Facets old units.rb library). Do not attempt to use both at the same time.
#
# == Todo
#
# * Currently kilo, mega, etc. are all powers of two and not ten,
#   which technically isn't corrent even though it is common usage.
# * The in_* notation is weak. If a better nomentclature is thought
#   of then consider changing this.
#
# == Copying
#
# Copyright (c) 2005 Rich Kilmer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.


# = Bytes
#
# Additional methods for Numeric class to make working with
# bits and bytes easier. Bits are used as the base value and
# these methods can be used to convert between different
# magnitudes.
#
#   1.byte               #=> 8
#   2.bytes              #=> 16
#   1.kilobit            #=> 1024
#   1.kilobyte           #=> 8192
#
# Use the in_* methods to perform the inverse operations.
#
#   8192.in_kilobytes    #=> 1
#   1024.in_kilobits     #=> 1
#
class Numeric

  def bit   ; self ; end
  def bits  ; self ; end
  def byte  ; self * 8 ; end
  def bytes ; self * 8 ; end

  [ 'kilo', 'mega', 'giga', 'tera', 'peta', 'exa' ].each_with_index do |m, i|
    j = i + 1
    class_eval %{
      def #{m}bit  ; self * #{1024**j} ; end
      def #{m}byte ; self * #{1024**j*8} ; end
      def in_#{m}bits  ; self / #{1024**j} ; end
      def in_#{m}bytes ; self / #{1024**j*8} ; end
      alias_method :#{m}bits,  :#{m}bit
      alias_method :#{m}bytes, :#{m}byte
    }
  end

  [ 'kibi', 'mebi', 'gibi', 'tebi', 'pebi', 'exbi' ].each_with_index do |m, i|
    j = i + 1
    class_eval %{
      def #{m}bit  ; self * #{1024**j} ; end
      def #{m}byte ; self * #{1024**j*8} ; end
      def in_#{m}bits  ; self / #{1024**j} ; end
      def in_#{m}bytes ; self / #{1024**j*8} ; end
      alias_method :#{m}bits,  :#{m}bit
      alias_method :#{m}bytes, :#{m}byte
    }
  end

  # Formated string of bits proportial to size.
  #
  #   1024.bits_to_s            #=> "1.00 kb"
  #   1048576.bits_to_s         #=> "1.00 mb"
  #   1073741824.bits_to_s      #=> "1.00 gb"
  #   1099511627776.bits_to_s   #=> "1.00 tb"
  #
  # Takes a format string to adjust output.
  #
  #   1024.bits_to_s('%.0f')    #=> "1 kb"
  #
  def strfbits(fmt='%.2f')
    case
    when self < 1024
      "#{self} bits"
    when self < 1024**2
      "#{fmt % (self.to_f / 1024)} kb"
    when self < 1024**3
      "#{fmt % (self.to_f / 1024**2)} mb"
    when self < 1024**4
      "#{fmt % (self.to_f / 1024**3)} gb"
    when self < 1024**5
      "#{fmt % (self.to_f / 1024**4)} tb"
    else
      "#{self} bits"
    end
  end

  # Formated string of bytes proportial to size.
  #
  #   1024.bytes_to_s            #=> "1.00 KB"
  #   1048576.bytes_to_s         #=> "1.00 MB"
  #   1073741824.bytes_to_s      #=> "1.00 GB"
  #   1099511627776.bytes_to_s   #=> "1.00 TB"
  #
  # Takes a format string to adjust output.
  #
  #   1024.bytes_to_s('%.0f')    #=> "1 KB"
  #
  def strfbytes(fmt='%.2f')
    case
    when self < 1024
      "#{self} bytes"
    when self < 1024**2
      "#{fmt % (self.to_f / 1024)} KB"
    when self < 1024**3
      "#{fmt % (self.to_f / 1024**2)} MB"
    when self < 1024**4
      "#{fmt % (self.to_f / 1024**3)} GB"
    when self < 1024**5
      "#{fmt % (self.to_f / 1024**4)} TB"
    else
      "#{self} bytes"
    end
  end

  # deprecated
  alias_method :octet_units, :strfbytes

end

