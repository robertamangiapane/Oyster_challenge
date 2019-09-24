require 'oystercard'
require 'station'

describe Oystercard do
  let(:max_balance) { described_class::DEFAULT_LIMIT }
  let(:min_amount) { described_class::MINIMUM_AMOUNT }
  it 'has a balance' do
    expect(subject.balance).to eq 0.00
  end

  describe '#top_up' do
    it 'top_up allows money to be added to balance' do
      expect { subject.top_up(1.00) }.to change { subject.balance }.by 1
    end

    it 'has a limit on the balance' do
      subject.top_up(max_balance)
      expect(subject.top_up(1.00)).to eq 'Exceeded card balance limit'
    end
  end

  describe '#touch_in' do
    it 'checks the minimum amount' do
      expect { subject.touch_in }.to raise_error 'Insufficient balance'
    end
    it 'starts a journey' do
      subject.top_up(10.00)
      allow(subject).to receive(:in_journey?).and_return(true)
    end
  end

  describe '#touch_out' do
    it 'ends a journey' do
      subject.touch_out
      allow(subject).to receive(:in_journey?).and_return(false)
    end

    it 'charge on touch_out' do
      subject.top_up(10.00)
      subject.touch_in
      expect { subject.touch_out } .to change { subject.balance }.by(- min_amount)
    end
  end

  # describe '#calculate' do
  #   it 'calculates a fare given start and end locations' do
  #     expect { card.calculate(1, 4) }.to change { card.balance }.by(6.00)
  #   end
  # end




end
