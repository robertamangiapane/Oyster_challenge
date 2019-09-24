require 'station'

describe Station do

  let(:name) { 'Aldgate' }
  let(:zone) { '1' }
  let(:station) {described_class.new(name, zone)}

  it 'has a name' do
    expect(station.name.empty?).to eq false
  end
  it 'has a zone' do
    expect(station.zone.empty?).to eq false
  end

end
