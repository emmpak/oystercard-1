require 'fare'

describe Fare do
  subject(:fare) { described_class.new }

  describe 'calculator' do
    it 'calucates fare based on station zones' do
      entry_zone = 1
      exit_zone = 3
      expect(fare.calculate(entry_zone, exit_zone)).to eq 3
    end
  end

end



#
# trip.keys[0].zone
# trip.values[0].zone
