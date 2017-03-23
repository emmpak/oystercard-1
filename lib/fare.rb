require_relative 'station'

#calculates fare based on station zones
class Fare

  def calculate(trip)
    entry_zone = trip.keys.last.zone
    exit_zone = trip.values.last.zone
    1 + (entry_zone - exit_zone).abs
  end
end
