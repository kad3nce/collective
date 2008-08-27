require 'english/double_metaphone'
require 'test/unit'

#require 'fastercsv'

# 1218 tests, 2436 assertions

class TC_DoubleMetaphone < Test::Unit::TestCase

  DIR  = File.dirname(__FILE__)
  DATA = File.read(File.join(DIR,'fixture/double_metaphone.txt')).split(/\n/)

  DATA.each_with_index do |line, i|
    row = *line.split(', ')
    primary, secondary = English::DoubleMetaphone[row[0]]

    define_method("test_#{i}") do
      assert_equal row[1], primary
      assert_equal row[2], (secondary.nil?? primary : secondary)
    end
  end

end
