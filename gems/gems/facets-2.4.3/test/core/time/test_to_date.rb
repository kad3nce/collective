require 'facets/time/to_date'
require 'test/unit'

class TestTimeConversion < Test::Unit::TestCase

  def test_to_date
    t = Time.now #parse('4/20/2005 15:37')
    assert_instance_of( ::Date, t.to_date )
  end

end

