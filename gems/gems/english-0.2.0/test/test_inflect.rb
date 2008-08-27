require 'english/inflect'
require 'test/unit'

class TestInflect < Test::Unit::TestCase

  tests = [
    [ "Americans", "American" ],
    [ "analyses", "analysis" ],
    [ "archives", "archive" ],
    [ "bays", "bay" ],
    [ "bureaus", "bureau" ],
    [ "businesses", "business" ],
    [ "cacti", "cactus" ],
    [ "cactuses", "cactus" ],
    [ "calves", "calf" ],
    [ "carpets", "carpet" ],
    [ "chiefs", "chief" ],
    [ "choruses", "chorus" ],
    [ "churches", "church" ],
    [ "companies", "company" ],
    [ "courses", "course" ],
    [ "cows", "cow" ],
    [ "crashes", "crash" ],
    [ "criteria", "criterion" ],
    [ "discos", "disco" ],
    [ "doors", "door" ],
    [ "factories", "factory" ],
    [ "farms", "farm" ],
    [ "farmers", "farmer" ],
    [ "faxes", "fax" ],
    [ "firemen", "fireman" ],
    [ "fish", "fish" ],
    [ "flowers", "flower" ],
    [ "forum", "fora" ],
    [ "forks", "fork" ],
    [ "foxes", "fox" ],
    [ "friends", "friend" ],
    [ "garages", "garage" ],
    [ "gardens", "garden" ],
    [ "geese", "goose" ],
    [ "girls", "girl" ],
    [ "grown-ups", "grown-up" ],
    [ "halves", "half" ],
    [ "heroes", "hero" ],
    [ "highways", "highway" ],
    [ "hives", "hive" ],
    [ "horses", "horse" ],
    [ "hovercraft", "hovercraft" ],
    [ "indexes", "index" ],
    [ "indices", "index" ],
    [ "kisses", "kiss" ],
    [ "lives", "life" ],
    [ "lights", "light" ],
    [ "loaves", "loaf" ],
    [ "memos", "memo" ],
    [ "men", "man" ],
    [ "mountains", "mountain" ],
    [ "mice", "mouse" ],
    [ "ovens", "oven" ],
    [ "oxen", "ox" ],
    [ "parties", "party" ],
    [ "pens", "pen" ],
    [ "pennies", "penny" ],
    [ "potatoes", "potato" ],
    [ "prizes", "prize" ],
    [ "proofs", "proof" ],
    [ "scarves", "scarf" ],
    [ "series", "series" ],
    [ "staples", "staple" ],
    [ "statuses", "status" ],
    [ "stores", "store" ],
    [ "Swiss", "Swiss" ],
    [ "tables", "table" ],
    [ "take-offs", "take-off" ],
    [ "teachers", "teacher" ],
    [ "theses", "thesis" ],
    [ "thieves", "thief" ],
    [ "tomatoes", "tomato" ],
    [ "torpedoes", "torpedo" ],
    [ "videos", "video" ],
    [ "watches", "watch" ]
  ]

  tests.each do |(p, s)|
    define_method("test_singular_of_#{p}") do
      assert_equal(s, p.singular)
    end

    define_method("test_plural_of_#{s}") do
      assert_equal(p, s.plural)
    end
  end
end
