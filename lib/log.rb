#adds all trips (both complete and incomplete) to journey history
class Log

  def initialize
    @journey_history = []
  end

  def add_trip(trip)
    journey_history << trip
  end

  private

  attr_reader :journey_history

end
