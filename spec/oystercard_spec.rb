require 'oystercard'
require 'station'

describe Oystercard do
  let(:max_balance) { described_class::DEFAULT_LIMIT }
  let(:min_amount) { described_class::MINIMUM_AMOUNT }
  let(:station_one) { double :station_one }
  let(:station_two) { double :station_two }

  it 'has a balance' do
    expect(subject.balance).to eq 0.00
  end

  describe ' #top_up' do
    it 'has a limit on the balance' do
      subject.top_up(max_balance)
      expect(subject.top_up(1.00)).to eq 'Exceeded card balance limit'
    end
    it 'top_up allows money to be added to balance' do
      expect { subject.top_up(1.00) }.to change { subject.balance }.by 1
    end
  end

  describe ' #touch_in' do
    it 'raise error if insufficient balance' do
      expect { subject.touch_in(station_one) }.to raise_error 'Insufficient balance'
    end
    it 'check if touch_out is missing' do
      subject.top_up(10.00)
      subject.touch_in(station_one)
      expect { subject.touch_in(station_one) }.to change { subject.balance }.by(-6)
    end
  end

  describe ' #touch_out' do
    before do
      subject.top_up(10.00)
      subject.touch_in(station_one)
    end

    it 'stores a journey' do
      subject.touch_out(station_two)
      journey = { entry_station: station_one, exit_station: station_two }
      expect(subject.journeys).to include(journey)
    end
    it 'return the new balance' do
      expect { subject.touch_out(station_two) }.to change(subject, :balance)
    end
    it 'check if touch_in is missing' do
      subject.touch_out(station_two)
      expect { subject.touch_out(station_two) }.to change { subject.balance }.by(-6)
    end
  end
end
