require_relative 'station'

#calculates fare based on station zones
class Fare

  MINIMUM_FARE = 1

  def calculate(trip)
    entry_zone = trip.keys.last.zone
    exit_zone = trip.values.last.zone
    MINIMUM_FARE + (entry_zone - exit_zone).abs
  end
end
