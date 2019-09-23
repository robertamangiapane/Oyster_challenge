require "station"

describe Station do

  let(:station) {described_class.new("1")}

  it "has a zone" do
    expect(station.zone.empty?).to eq false
  end

end
