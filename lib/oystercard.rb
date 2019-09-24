class Oystercard
  attr_accessor :balance
  attr_reader :journey

  DEFAULT_LIMIT = 90.00
  MINIMUM_AMOUNT = 2.00

  def initialize(limit = DEFAULT_LIMIT, min_amount = MINIMUM_AMOUNT)
    @limit = limit
    @min_amount = min_amount
    @balance = 0.00
  end

  def top_up(amount)
    return 'Exceeded card balance limit' if overlimit?(amount)

    @balance += amount
  end

  def touch_in
    raise 'Insufficient balance' if insufficient_funds?

    @journey = true
  end

  def touch_out(min_amount)
    @journey = false
    deduct(min_amount)
  end

  # def calculate(start, finish)
  #   @balance = (finish - start) * 2
  # end

  private

  def in_journey?
    @journey
  end

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
