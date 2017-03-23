require 'journeylog'

describe JourneyLog do
  subject(:log) { described_class.new }

  describe 'initialize' do
    it 'has an empty array of journey history' do
      expect(log.journey_history).to be_empty
    end
  end

  describe '#logger' do
    it 'adds complete journey to log' do
      current_trip = double(:current_trip)
      log.add_trip(current_trip)
      expect(log.journey_history).to include current_trip
    end
  end


end
