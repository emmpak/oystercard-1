require_relative 'fare'

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
    @amount = fare.calculate(current_trip)
  end

  private

  attr_writer :current_trip

end
