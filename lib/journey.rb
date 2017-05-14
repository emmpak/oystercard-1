require_relative 'fare'
require_relative 'station'

#Compiles entry station and exit station to a journey.
#Gets fare and sends it to oystercard
class Journey
  attr_reader :current_trip, :fare, :amount

  def initialize
    @current_trip = {}
    @fare = Fare.new
  end

  def start(entry_station)
    self.current_trip = {entry_station => nil}
  end

  def finish(exit_station)
    self.current_trip = {current_trip.keys[0] => exit_station}
    p current_trip
    get_zones(current_trip)
  end

  private

  attr_writer :current_trip, :amount

  def get_zones(current_trip)
    entry_zone = current_trip.keys.last.zone
    exit_zone = current_trip.values.last.zone
    get_fare(entry_zone, exit_zone)
  end

  def get_fare(entry_zone, exit_zone)
    self.amount = fare.calculate(entry_zone, exit_zone)
  end

end
