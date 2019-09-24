class Oystercard
  attr_reader :balance, :journey, :entry_station

  DEFAULT_LIMIT = 90.00
  MINIMUM_AMOUNT = 2.00

  def initialize(limit = DEFAULT_LIMIT, min_amount = MINIMUM_AMOUNT)
    @limit = limit
    @min_amount = min_amount
    @balance = 0.00
    @entry_station = []
    @journey = false
  end

  def top_up(amount)
    return 'Exceeded card balance limit' if overlimit?(amount)

    @balance += amount
  end

  def touch_in(station_name)
    raise 'Insufficient balance' if insufficient_funds?

    @journey = true
    @entry_station << station_name
  end

  def touch_out
    deduct(@min_amount)
    @journey = false
    @entry_station = nil
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
