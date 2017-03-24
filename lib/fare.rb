require_relative 'station'

#calculates fare based on station zones
class Fare

  MINIMUM_FARE = 1

  def calculate(entry_zone, exit_zone)
    MINIMUM_FARE + (entry_zone - exit_zone).abs
  end
end
