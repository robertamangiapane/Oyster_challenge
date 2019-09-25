require 'journey'
require 'station'

describe Journey do
  let(:station_one) { double :station_one }
  let(:station_two) { double :station }

  describe '#commuting' do
    it 'starts a journey' do
      expect(subject.commuting?).to eq true
    end
    it 'ends a journey' do
      subject.end_journey
      expect(subject.commuting?).to eq false
    end
  end

  describe '#calculate_fare' do
    it 'calculate_fare' do
      expect(subject.calculate_fare(station_one, station_two)).to eq subject.fare
    end
  end
end
