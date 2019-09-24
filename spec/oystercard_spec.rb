require 'oystercard'
require 'station'

describe Oystercard do
  let(:max_balance) { described_class::DEFAULT_LIMIT }
  let(:min_amount) { described_class::MINIMUM_AMOUNT }
  let(:station1) { Station.new('Aldgate', '1') }
  let(:station2) { Station.new('Liverpool St', '1') }

  it 'has a balance' do
    expect(subject.balance).to eq 0.00
  end

  it 'has a empty journey by default' do
    expect(subject.journeys).to be_empty
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
      expect { card.touch_in(station1) }.to raise_error 'Insufficient balance'
    end
    before do
      subject.top_up(10.00)
      subject.touch_in(station1)
    end
    it 'starts a journey' do
      expect(subject.commute).to eq true
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(10.00)
      subject.touch_in(station1)
    end
    it 'ends a journey' do
      subject.touch_out(station2)
      expect(subject.in_journey?).to eq nil
    end

    it 'charge on touch_out' do

      expect { subject.touch_out(station2) }.to change { subject.balance }.by(- min_amount)
    end

    it 'set entry station eq nil' do
      expect { subject.touch_out(station2) }.to change { subject.entry_station }.to(nil)
    end

    it ' stores ea journey' do
      subject.touch_out(station2)
      journey = {:entry_station => station1, :exit_station => station2}
      expect(subject.journeys).to include(journey)
    end
  end




end
