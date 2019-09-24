require 'oystercard'
require 'station'

describe Oystercard do
  let(:max_balance) { described_class::DEFAULT_LIMIT }
  let(:min_amount) { described_class::MINIMUM_AMOUNT }
  let(:station_name) { Station.new(' Aldgate ') }

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
    let(:card) { Oystercard.new }
    it 'checks the minimum amount' do
      expect { card.touch_in(station_name) }.to raise_error 'Insufficient balance'
    end
    before do
      subject.top_up(10.00)
      subject.touch_in(station_name)
    end
    it 'starts a journey' do
      expect(subject.in_journey?).to eq true
    end
    it ' stores entry station' do
      expect(subject.entry_station).to include(station_name)
    end
  end

  describe '#touch_out' do
    it 'ends a journey' do
      subject.top_up(10.00)
      subject.touch_in(station_name)
      subject.touch_out
      expect(subject.in_journey?).to eq nil
    end

    it 'charge on touch_out' do
      subject.top_up(10.00)
      subject.touch_in(station_name)
      expect { subject.touch_out }.to change { subject.balance }.by(- min_amount)
    end

    it 'set entry station eq nil' do
      subject.top_up(10.00)
      subject.touch_in(station_name)
      expect { subject.touch_out }.to change { subject.entry_station }.to(nil)
    end
  end




end
