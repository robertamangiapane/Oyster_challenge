class Oystercard
  attr_accessor :balance
  attr_reader :journey

  DEFAULT_LIMIT = 100.00
  MINIMUM_AMOUNT = 2.00

  def initialize
    @balance = 0.00

  end

  def add(amount)
    return "Exceeded card balance limit" if overlimit?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail "Insufficient balance" if insufficient_funds?
    @journey = true
  end

  def touch_out(fare)
    @journey = false
    deduct(fare)
  end

  def overlimit?(amount)
    @balance + amount > DEFAULT_LIMIT
  end

  def insufficient_funds?
    @balance <= MINIMUM_AMOUNT
  end

  def calculate(start, finish)

  end

end
