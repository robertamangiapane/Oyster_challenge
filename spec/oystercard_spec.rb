require 'oystercard'

describe Oystercard do

  let(:card) {described_class.new}

  it "has a balance" do
    expect(card.balance).to eq 0.00
  end

  it "allows money to be added to balance" do
    card.add(1.00)
    expect(card.balance).to eq 1.00
  end

  it "has a limit on the balance" do
    card.add(100.00)
    expect(card.add(1.00)).to eq "Exceeded card balance limit"
  end

end
