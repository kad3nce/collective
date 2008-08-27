require 'english/similarity'
require 'test/unit'

class TestSimilarity < Test::Unit::TestCase

  # TODO: Need to test better.

  def test_similarity
    assert_nothing_raised { "Hello World!".similarity( "helo wrld" ) }
  end

end

