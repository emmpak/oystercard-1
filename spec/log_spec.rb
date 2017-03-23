require 'log'

describe Log do
  subject(:log) { described_class.new }

  describe 'initialize' do
    it 'has an empty array of journey history' do
      expect(log.journey_history).to be_empty
    end
  end

  describe '#add_trip' do
    it 'adds complete journey to log' do
      trip = double(:trip)
      log.add_trip(trip)
      expect(log.journey_history).to include trip
    end
  end


end
