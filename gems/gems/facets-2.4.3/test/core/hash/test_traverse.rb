require 'facets/hash/traverse'
require 'test/unit'

class TC_Hash_Traverse < Test::Unit::TestCase

  def test_traverse
    h = { "A" => "x", "B" => "y" }
    h2 = h.traverse { |k,v| [k.downcase, v.upcase] }
    e = { "a" => "X", "b" => "Y" }
    assert_not_equal( h, h2 )
    assert_equal( e, h2 )
  end

  def test_traverse!
    h = { "A" => "x", "B" => "y" }
    h.traverse! { |k,v| [k.downcase, v.upcase] }
    e = { "a" => "X", "b" => "Y" }
    assert_equal( e, h )
  end

end

