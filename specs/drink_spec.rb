require("minitest/autorun")
require_relative("../drink")

class TestDrink < MiniTest::Test

  def setup
    @drink1 = Drink.new("V+C",3.5)
    @drink2 = Drink.new("G+T", 4.0)
    @drink3 = Drink.new("Wine", 6.0)
    @drink4 = Drink.new("Beer", 3.75)
  end

  def test_drink_has_name
    assert_equal("G+T", @drink2.drink_name())
  end

  def test_drink_has_price
    assert_equal(6.0, @drink3.price())
  end

end
