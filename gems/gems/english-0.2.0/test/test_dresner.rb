require 'english/dresner'

require 'test/unit'

class TC_String < Test::Unit::TestCase

  def test_dresner
    # assert_still_legible ;-)
    assert_nothing_raised { "How are you today?".dresner }
  end

  def test_dresner
    # assert_still_legible ;-)
    assert_nothing_raised { "How are you today?".dresner! }
  end

end
