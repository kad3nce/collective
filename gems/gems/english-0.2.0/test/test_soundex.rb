require 'english/soundex'

require 'test/unit'
require 'yaml'

class TC_Soundex < Test::Unit::TestCase

  DIR  = File.dirname(__FILE__)
  DATA = YAML::load(File.read(File.join(DIR,'fixture/soundex.txt')))

  def test_cases
    DATA.each do |input, expected_output|
      assert_equal expected_output, English::Soundex.soundex(input)
    end
  end

end

class TC_String_Soundex < Test::Unit::TestCase

  def test_soundex
    assert_equal("Ruby".soundex, "R100")
  end

end
