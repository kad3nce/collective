# = NackClass
#
# Not Acknowledge. An alternatice to NilClass is cases where
# nil is a valid option, but an non-option still needs to
# be recorgnized.
#
# == Authors
#
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2004 Thomas Sawyer
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.


# = NackClass
#
# Not Acknowledge. An alternatice to NilClass is cases where
# nil is a valid option, but an non-option still needs to
# be recorgnized.
#
class NackClass < Exception
end

module Kernel
  # This is a light version of NackClass intended
  # for minor usecases. See mega/nack for a complete version.
  #
  def nack
    NackClass.new
  end
end
