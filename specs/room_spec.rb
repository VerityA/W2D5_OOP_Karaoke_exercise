require("minitest/autorun")
require_relative("../room")
require_relative("../song")
require_relative("../guest")
require_relative("../bar")
require_relative("../drink")

class TestRoom < MiniTest::Test

  def setup

    @guest1 = Guest.new("George", @song2, 50)
    @guest2 = Guest.new("Ruby", @song3, 30)
    @guest3 = Guest.new("Dave", @song1, 40)
    @guest4 = Guest.new("Serena", @song4, 30)
    @guest5 = Guest.new("Josh", @song3, 25)
    @guest6 = Guest.new("Neil", @song5, 5)

    @song1 = Song.new("I Kissed a Girl", "Katy Perry")
    @song2 = Song.new("Hello", "Adele")
    @song3 = Song.new("Take a Bow", "Rihanna")
    @song4 = Song.new("Cry Me a River", "Justin Timberlake")
    @song5 = Song.new("Like a bird", "Nelly Furtado")

    @song_library = [@song1, @song2, @song3, @song4]
    @room = Room.new(@song_library)

    @drink1 = Drink.new("V+C",3.5)
    @bar = Bar.new([@drink1, @drink2, @drink3, @drink4])


  end

  def test_song_library
    song_library = @room.song_library()
    assert_equal([@song1, @song2, @song3, @song4], song_library)
  end

  def test_guests__start
    guests = @room.guests()
    assert_equal([], guests)
  end

  def test_guest_count
    guest_count = @room.guest_count()
    assert_equal(0, guest_count)
  end

  def test_playlist_content__start
    playlist = @room.playlist()
    assert_equal([], playlist)
  end

  def test_has_entry_fee
    entry_fee = @room.entry_fee()
    assert_equal(10, entry_fee)
  end

  def test_capacity_limit
    capacity_limit = @room.capacity()
    assert_equal(5, capacity_limit)
  end

  def test_entry_takings__start
    entry_takings = @room.entry_takings()
    assert_equal(0, entry_takings)
  end

  def test_add_to_playlist__songs_in_library
    @room.add_to_playlist([@song1, @song2])
    playlist = @room.playlist()
    assert_equal([@song1, @song2], playlist)
  end

  def test_add_to_playlist__not_all_songs_in_library
    @room.add_to_playlist([@song1, @song5, @song4])
    playlist = @room.playlist()
    assert_equal([@song1, @song4], playlist)
  end

  def test_check_in_guests__capacity_reached
    @room.check_in_guests([@guest1, @guest2, @guest3, @guest4, @guest5])
    @room.check_in_guests([@guest1, @guest2])
    guest_count = @room.guests().count
    assert_equal(5, guest_count)
  end

  def test_check_in_guests__capacity_not_reached
    @room.check_in_guests([@guest1, @guest2])
    guest_count = @room.guests().count
    assert_equal(2, guest_count)
  end

  def test_check_in_guests__capacity_not_reached_sufficient_funds
    @room.check_in_guests([@guest1, @guest2])
    guest_count = @room.guests().count
    wallet_value_1 = @guest1.wallet_value()
    wallet_value_2 = @guest2.wallet_value()
    entry_takings = @room.entry_takings()
    assert_equal(2, guest_count)
    assert_equal(40, wallet_value_1)
    assert_equal(20, wallet_value_2)
    assert_equal(20, entry_takings)
  end

  def test_check_in_guests__capacity_not_reached_insufficient_funds
    @room.check_in_guests([@guest1, @guest6])
    guest_count = @room.guests().count
    wallet_value_1 = @guest1.wallet_value()
    wallet_value_2 = @guest6.wallet_value()
    entry_takings = @room.entry_takings()
    assert_equal(1, guest_count)
    assert_equal(40, wallet_value_1)
    assert_equal(5, wallet_value_2)
    assert_equal(10, entry_takings)
  end

  def test_check_out_guests__guest_in_room
    @room.check_in_guests([@guest1, @guest2])
    @room.check_out_guests([@guest1])
    guest_count = @room.guests().count
    assert_equal(1, guest_count)
  end

  def test_check_out_guests__guest_not_in_room
    @room.check_in_guests([@guest2])
    @room.check_out_guests([@guest1])
    guest_count = @room.guests().count
    assert_equal(1, guest_count)
  end

  def test_total_takings
    @room.check_in_guests([@guest1])
    @bar.sell_drink(@room, @guest1, @drink1)
    total_takings = @room.total_takings()
    # assert_equal(13.5, @room.total_takings)
    assert_equal(10, @room.entry_takings())
    assert_equal(3.5, @room.bar_tab())
  end

  def test_bar_tab
    assert_equal(0, @room.bar_tab())
  end

  def test_increase_bar_tab
    @room.increase_bar_tab(@drink1)
    assert_equal(3.5, @room.bar_tab())
  end

end
