require 'oystercard'
require 'station'

describe Oystercard do
  let(:max_balance) { described_class::DEFAULT_LIMIT }
  let(:min_amount) { described_class::MINIMUM_AMOUNT }
  let(:card) { described_class.new }
  it 'has a balance' do
    expect(card.balance).to eq 0.00
  end

  describe '#top_up' do
    it '#top_ip allows money to be added to balance' do
      card.top_up(1.00)
      expect(card.balance).to eq 1.00
    end

    it 'has a limit on the balance' do
      card.top_up(max_balance)
      expect(card.top_up(1.00)).to eq 'Exceeded card balance limit'
    end
  end

  describe '#touch_in' do
    it 'checks the minimum amount' do
      expect { card.touch_in }.to raise_error 'Insufficient balance'
    end
    it 'starts a journey' do
      card.balance = 10.00
      allow(card).to receive(:in_journey?).and_return(true)
    end
  end

  describe '#touch_out' do
    it 'ends a journey' do
      card.touch_out(min_amount)
      allow(card).to receive(:in_journey?).and_return(false)
    end
  end

  describe '#deduct' do
    it 'deducts the fare automatically when the journey has ended' do
      card.balance = 10.00
      card.touch_in
      expect(card.touch_out(min_amount)).to eq 8.00
    end
  end

  # describe '#calculate' do
  #   it 'calculates a fare given start and end locations' do
  #     expect { card.calculate(1, 4) }.to change { card.balance }.by(6.00)
  #   end
  # end




end
