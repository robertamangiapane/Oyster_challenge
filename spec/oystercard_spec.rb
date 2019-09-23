require 'oystercard'
require 'station'

describe Oystercard do

  let(:max_balance) { described_class::DEFAULT_LIMIT }

  let(:card) {described_class.new}

  it "has a balance" do
    expect(card.balance).to eq 0.00
  end

  it "#add allows money to be added to balance" do
    card.add(1.00)
    expect(card.balance).to eq 1.00
  end

  it "has a limit on the balance" do
    card.add(max_balance)
    expect(card.add(1.00)).to eq "Exceeded card balance limit"
  end


  describe "#deduct" do

    it "deducts fare from the balance" do
      card.add(2.00)
      card.deduct(1.50)
      expect(card.balance).to eq 0.50
    end

    it "deducts the fare automatically when the journey has ended" do
      card.add(10.00)
      card.touch_in
      expect(card.touch_out(2.00)).to eq 8.00
    end

  end



  describe "#touch_in" do

    it "checks the minimum amount" do
      expect {card.touch_in}.to raise_error "Insufficient balance"
    end

    it "starts a journey" do
      card.add(10.00)
      expect(card.touch_in).to eq true
    end

  end

  describe "#touch_out" do

    it "ends a journey" do
      card.touch_out(2.00)
      expect(card.journey).to eq false
    end

  end

  describe "#calculate" do

    it "calculates a fare given start and end locations" do
      expect(card.calculate(1, 4)).to eq 6.00
    end

  end




end
