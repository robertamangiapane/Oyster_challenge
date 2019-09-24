class Oystercard
  attr_reader :balance, :commute, :journeys, :entry_station, :exit_station

  DEFAULT_LIMIT = 90.00
  MINIMUM_AMOUNT = 2.00

  def initialize(limit = DEFAULT_LIMIT, min_amount = MINIMUM_AMOUNT)
    @limit = limit
    @min_amount = min_amount
    @balance = 0.00
    @journeys = []
    @commute = false
  end

  def top_up(amount)
    return 'Exceeded card balance limit' if overlimit?(amount)

    @balance += amount
  end

  def touch_in(station_one)
    raise 'Insufficient balance' if insufficient_funds?

    @commute = true
    @entry_station = station_one
  end

  def touch_out(station_two)
    deduct(@min_amount)
    @exit_station = station_two
    add_journey
    @commute = false
    @entry_station = nil
    @exit_station = nil
  end

  def add_journey
    @journeys = [{ entry_station: @entry_station, exit_station: @exit_station }]
  end

  def in_journey?
    return true if @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def overlimit?(amount)
    @balance + amount > DEFAULT_LIMIT
  end

  def insufficient_funds?
    @balance <= MINIMUM_AMOUNT
  end
end
