require 'english/porter_stemming'

require 'test/unit'

class TC_PorterStemming < Test::Unit::TestCase

  DIR  = File.dirname(__FILE__)
  DATA_INPUT  = File.read(File.join(DIR,'fixture/porter_stemming_input.txt')).split(/\n/)
  DATA_OUTPUT = File.read(File.join(DIR,'fixture/porter_stemming_output.txt')).split(/\n/)

  #def slurp(*path)
  #  File.read(File.join(DIR,*path)).split(/\n/)
  #end

  def test_cases
    cases = DATA_INPUT.zip(DATA_OUTPUT)
    cases.each do |word, expected_output|
      assert_equal expected_output, English::PorterStemming.stem(word)
    end
  end

end
