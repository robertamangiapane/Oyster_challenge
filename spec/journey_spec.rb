require 'journey'
require 'station'

describe Journey do
  let(:station_one) { Station.new('Aldgate', '1') }
  let(:station_two) { Station.new('Liverpool St', '1') }

  it 'starts a journey' do
    expect(subject.commuting).to eq true
  end

  it 'has a empty journey by default' do
    expect(subject.journeys).to be_empty
  end

  it 'has an empty entry station' do
    expect(subject.entry_station).to be_empty
  end

  it 'has an empty exit station' do
    expect(subject.exit_station).to be_empty
  end

  it 'ends a journey' do
    subject.add_journey(station_one, station_two)
    expect(subject.commuting).to eq false
  end

  it 'resets entry_station' do
    subject.add_journey(station_one, station_two)
    expect(subject.entry_station).to eq nil
  end

  it 'resets exit_station' do
    subject.add_journey(station_one, station_two)
    expect(subject.exit_station).to eq nil
  end

  describe '#add_journey' do
    it 'stores a journey' do
      subject.add_journey(station_one, station_two)
      journey = { entry_station: station_one, exit_station: station_two }
      expect(subject.journeys).to include(journey)
    end
  end
end
