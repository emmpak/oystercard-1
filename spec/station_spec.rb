require 'station'

describe Station do

  subject(:station) {described_class.new("Old Street")}

  describe "#initalize" do

    it 'has a name on creation' do
      expect(station.name).to eq "Old Street"
    end

    it 'looks up stations zone from csv' do
      expect(station.zone).to eq 1
    end
  end

end
