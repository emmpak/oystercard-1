
class JourneyLog

  attr_reader :journey_history

  def initialize
    @journey_history = []
  end

  def add_trip(current_trip)
    journey_history << current_trip
  end

end
