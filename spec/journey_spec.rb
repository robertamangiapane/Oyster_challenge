require 'journey'
require 'station'

describe Journey do
  let(:station_one) { double :station_one }
  let(:station_two) { double :station }

  it 'has an empty entry station' do
    expect(subject.entry_station).to be_empty
  end

  it 'has an empty exit station' do
    expect(subject.exit_station).to be_empty
  end

  it 'starts a journey' do
    expect(subject.commuting?).to eq true
  end

  it 'ends a journey' do
    subject.end_journey
    expect(subject.commuting?).to eq false
  end
end
