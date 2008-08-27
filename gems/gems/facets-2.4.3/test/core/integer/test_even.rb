require 'facets/integer/even'
require 'test/unit'

class TC_Integer < Test::Unit::TestCase

  def test_even?
    (-100..100).step(2) do |n|
      assert(n.even? == true)
    end
    (-101..101).step(2) do |n|
      assert(n.even? == false)
    end
  end

  def test_odd?
    (-101..101).step(2) do |n|
      assert(n.odd? == true)
    end
    (-100..100).step(2) do |n|
      assert(n.odd? == false)
    end
  end

end

