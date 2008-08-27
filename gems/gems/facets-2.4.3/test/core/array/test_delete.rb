require 'facets/array/delete'
require 'test/unit'

class TC_Array_Delete < Test::Unit::TestCase

  # delete

  def test_delete_unless
    a = [1,2,3]
    a.delete_unless{ |e| e == 2 }
    assert_equal( [2], a )
  end

  def test_delete_values
    a = [1,2,3,4]
    assert_equal( [1,2], a.delete_values(1,2) )
    assert_equal( [3,4], a )
  end

  def test_delete_values_at
    a = [1,2,3,4]
    assert_equal( [2,3], a.delete_values_at(1,2) )
    assert_equal( [1,4], a )
    a = [1,2,3,4]
    assert_equal( [1,2,3], a.delete_values_at(0..2) )
    assert_equal( [4], a )
  end

end

