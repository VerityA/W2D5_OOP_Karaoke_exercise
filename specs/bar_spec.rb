require("minitest/autorun")
require_relative("../bar")
require_relative("../guest")
require_relative("../room")
require_relative("../drink")

class TestBar < MiniTest::Test

  def setup
    @drink1 = Drink.new("V+C",3.5)
    @drink2 = Drink.new("G+T", 4.0)
    @drink3 = Drink.new("Wine", 6.0)
    @drink4 = Drink.new("Beer", 3.75)

    @guest1 = Guest.new("George", @song2, 50)
    @guest2 = Guest.new("Ruby", @song4, 5)

    @bar = Bar.new([@drink1, @drink2, @drink3, @drink4])
    @room = Room.new(@song_library)
  end

  def test_bar_has_drinks
    assert_equal([@drink1, @drink2, @drink3, @drink4], @bar.drinks())
  end

  def test_bar_takings
    assert_equal(0, @bar.bar_takings())
  end

  def test_sell_drink__drink_available_can_afford
    @bar.sell_drink(@room, @guest1, @drink4)
    assert_equal([@drink1, @drink2, @drink3], @bar.drinks)
    room_bar_tab = @room.bar_tab()
    assert_equal(3.75, room_bar_tab)
    guest_wallet_value = @guest1.wallet_value()
    assert_equal(46.25, guest_wallet_value)
  end

  def test_sell_drink__drink_available_cannot_afford
    @bar.sell_drink(@room, @guest2, @drink3)
    assert_equal([@drink1, @drink2, @drink3, @drink4], @bar.drinks)
    room_bar_tab = @room.bar_tab()
    assert_equal(0, room_bar_tab)
    guest_wallet_value = @guest2.wallet_value()
    assert_equal(5, guest_wallet_value)
  end

  def test_collect_bar_takings
    @bar.sell_drink(@room, @guest1, @drink1)
    @bar.sell_drink(@room, @guest1, @drink3)
    @bar.sell_drink(@room, @guest1, @drink2)
    @bar.collect_bar_takings(@room)
    assert_equal(13.5, @bar.bar_takings())
  end
end
