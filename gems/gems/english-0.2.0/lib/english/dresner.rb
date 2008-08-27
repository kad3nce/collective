# = TITLE:
#   Dresener Obfuscation
#
# = SYNOPSIS:
#   Means of distorting text.
#
# = AUTHORS:
#  - Trans
#  - Kurt Dresner


module English #:nodoc:

  module Dresner

    extend self

    # Scramble the inner characters of words leaving the text still readable
    # (research at Cambridge University, code by KurtDresner).
    #
    # For example, the above text may result in:
    #
    #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
    #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)

    def dresner(string)
      string.gsub(/\B\w+\B/){$&.split(//).sort_by{rand}}
    end

  end

end

# Extensions to String.

class String #:nodoc:

  # Scramble the inner characters of words leaving the text still readable
  # (research at Cambridge University, code by KurtDresner).
  #
  # For example, the above text may result in:
  #
  #   Srblamce the iennr cchrteaars of wodrs lvenaig the txet stlil rbeaadle
  #   (rreceash at Cbamigdre Uverintisy, cdoe by KrneruestDr?)

  def dresner
    English::Dresner.dresner(self)
  end

  # Inplace version of #dresner method.

  def dresner!
    replace(dresner)
  end

end
