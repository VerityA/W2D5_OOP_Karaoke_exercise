class Guest

  attr_reader :guest_name, :fave_song, :wallet_value

  def initialize(guest_name, fave_song, wallet_value)
    @guest_name = guest_name
    @fave_song = fave_song
    @wallet_value = wallet_value

  end

  def sing_song(song, fave_song)
    if song == fave_song
      return "Whoooooaaaa, #{song.song_name()} la la la"
    end
    return "La la la, #{song.song_name()}, la la la"
  end

  def sufficient_funds(item_cost)
    @wallet_value >= item_cost
  end

  def check_in(entry_fee)
    @wallet_value -= entry_fee
  end

  def buy_drink(drink)
    @wallet_value -= drink.price()
  end

end
