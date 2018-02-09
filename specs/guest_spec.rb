require("minitest/autorun")
require_relative("../guest")
require_relative("../song")
require_relative("../room")
require_relative("../drink")
require_relative("../bar")

class TestGuest < MiniTest::Test

  def setup
    @song1 = Song.new("I Kissed a Girl", "Katy Perry")
    @song2 = Song.new("Like a bird", "Nelly Furtado")
    @song3 = Song.new("Sorry", "Justin Bieber")
    @song4 = Song.new("Cry Me a River", "Justin Timberlake")
    @song5 = Song.new("Like a bird", "Nelly Furtado")

    @guest1 = Guest.new("George", @song2, 50)
    @guest2 = Guest.new("Ruby", @song4, 5)

    @drink1 = Drink.new("V+C",3.5)

    @song_library = [@song1, @song2, @song3, @song4]
    @room = Room.new(@song_library)
  end

  def test_wallet_value
    assert_equal(50, @guest1.wallet_value())
  end

  def test_fave_song
    assert_equal(@song2, @guest1.fave_song())
  end

  def test_guest_name
    assert_equal("George", @guest1.guest_name())
  end

  def test_sing_song__not_fave_song
    singing = @guest1.sing_song(@song1, @song2)
    assert_equal("La la la, I Kissed a Girl, la la la", singing)
  end

  def test_sing_song__fave_song
    singing = @guest1.sing_song(@song2, @song2)
    assert_equal("Whoooooaaaa, Like a bird la la la", singing)
  end

  def test_sufficient_funds__true
    sufficient_funds = @guest1.sufficient_funds(@room.entry_fee())
    assert_equal(true, sufficient_funds)
  end

  def test_sufficient_funds__false
    sufficient_funds = @guest2.sufficient_funds(@room.entry_fee())
    assert_equal(false, sufficient_funds)
  end

  def test_check_in
    @guest1.check_in(@room.entry_fee())
    wallet_value = @guest1.wallet_value()
    assert_equal(40, wallet_value)
  end

  def test_buy_drink
    @guest1.buy_drink(@drink1)
    wallet_value = @guest1.wallet_value()
    assert_equal(46.5, wallet_value)
  end

end
