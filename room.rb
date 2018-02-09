class Room

  attr_reader :song_library, :guests, :playlist, :entry_fee, :capacity, :entry_takings, :total_takings, :bar_tab


  def initialize(song_library)
    @song_library = song_library
    @guests = []
    @playlist =[]
    @entry_fee = 10
    @capacity = 5
    @entry_takings = 0
    @bar_tab = 0
    @total_takings = @entry_takings + @bar_tab
  end

  def add_to_playlist(songs)
    songs.each do |song|
      if @song_library.include?(song)
        @playlist << song
      end
    end
  end

  def guest_count()
    return @guests.count()
  end

  def check_in_guests(guests)
    return if guest_count() > ( @capacity - guest_count() )
    guests.each do |guest|
      if guest.sufficient_funds(@entry_fee)
        @guests << guest
        guest.check_in(@entry_fee)
        @entry_takings += @entry_fee
      end
    end
  end

  def check_out_guests(guests)
    guests.each { |guest|  @guests.delete(guest) }
  end

  def increase_bar_tab(drink)
    @bar_tab += drink.price()
  end


end
