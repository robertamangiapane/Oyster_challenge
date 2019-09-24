class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey

  DEFAULT_LIMIT = 90.00
  MINIMUM_AMOUNT = 2.00
  DEFAULT_PENALITY = 6

  def initialize(limit = DEFAULT_LIMIT, min_amount = MINIMUM_AMOUNT)
    @limit = limit
    @min_amount = min_amount
    @penality = DEFAULT_PENALITY
    @balance = 0.00
    @journey = nil
  end

  def top_up(amount)
    return 'Exceeded card balance limit' if overlimit?(amount)

    @balance += amount
  end

  def touch_in(station_one)
    raise 'Insufficient balance' if insufficient_funds?

    calculate_penality if @journey != nil
    @journey = Journey.new
    @entry_station = station_one
  end

  def touch_out(station_two)
    if @journey == nil
      calculate_penality
    else
      @journey.add_journey(@entry_station, station_two)
      @balance = deduct_fare
      @journey = nil
    end
  end

  def deduct_fare
    fare = @journey.calculate_fare
    @balance -= fare
  end

  def calculate_penality
    @balance -= @penality
  end

  private

  def overlimit?(amount)
    @balance + amount > @limit
  end

  def insufficient_funds?
    @balance <= @min_amount
  end
end
