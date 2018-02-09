class Bar

attr_reader :drinks, :bar_takings


  def initialize(drinks)
    @drinks = drinks
    @bar_takings = 0
  end

  def sell_drink(room, guest, drink)
    if @drinks.include?(drink)
       if guest.sufficient_funds(drink.price())
        guest.buy_drink(drink)
        @drinks.delete(drink)
        room.increase_bar_tab(drink)
      end
    end
    return @drinks
  end

  def collect_bar_takings(room)
    @bar_takings += room.bar_tab()
  end

end
