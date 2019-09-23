class Oystercard
  attr_accessor :balance

  DEFAULT_LIMIT = 100.00

  def initialize
    @balance = 0.00
  end

  def add(amount)
    return "Exceeded card balance limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end


end
