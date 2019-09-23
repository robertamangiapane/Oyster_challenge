class Oystercard
  attr_accessor :balance

  DEFAULT_LIMIT = 100.00

  def initialize
    @balance = 0.00
    @minimum_amount = 2.00
  end

  def add(amount)
    return "Exceeded card balance limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail "Insufficient balance" if @balance <= @minimum_amount
    @journey = true
  end

  def touch_out
    @journey = false
  end

  private

  def in_journey?
    @journey
  end
end
