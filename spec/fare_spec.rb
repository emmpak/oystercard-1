require 'fare'

describe Fare do
  subject(:fare) { described_class.new }

  describe 'calculator' do
    it 'calucates fare based on station zones' do
      # entry_station = double(:entry_station, zone: 3)
      # exit_station = double(:exit_station, zone: 1)
      trip = double(:trip)
      allow(trip).to receive_message_chain(:keys, :last, :zone) {1}
      allow(trip).to receive_message_chain(:values, :last, :zone) {3}
      expect(fare.calculate(trip)).to eq 3
    end
  end

end



#
# trip.keys[0].zone
# trip.values[0].zone
