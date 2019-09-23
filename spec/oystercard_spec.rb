require 'oystercard'

describe Oystercard do

  let(:card) {described_class.new}

  it "has a balance" do
    expect(card.balance).to eq 0.00
  end

  it "#add allows money to be added to balance" do
    card.add(1.00)
    expect(card.balance).to eq 1.00
  end

  it "has a limit on the balance" do
    card.add(100.00)
    expect(card.add(1.00)).to eq "Exceeded card balance limit"
  end

  it "#deduct deducts fare from the balance" do
    card.add(2.00)
    card.deduct(1.50)
    expect(card.balance).to eq 0.50
  end

  describe "#touch_in" do

    it "starts a journey" do
      card.add(10.00)
      expect(card.touch_in).to eq true
    end

    it "checks the minimum amount" do
      expect {card.touch_in}.to raise_error "Insufficient balance"
    end
  end

  it "#touch_out ends a journey" do
    expect(card.touch_out).to eq false
  end


end
