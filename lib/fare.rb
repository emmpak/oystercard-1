require_relative 'station'

class Fare

  def calculate(trip)
    entry_zone = trip.keys.last.zone
    exit_zone = trip.values.last.zone
    1 + (entry_zone - exit_zone).abs
  end
end
