require_relative 'journey'
require_relative 'log'
require_relative 'fare'

#Gets journey fares and deducts them from card balance
#sends completed journeys to card's log
#detects incomplete journeys and deducts penalty fare from balance
#returns error messages for topping up over maximum balance and running out of money
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey, :log

  def initialize
    @balance = 0
    @log = Log.new
  end

  def in_journey?
    !!journey
  end

  def top_up(amount)
    fail "Top up unsuccessful: Balance cannot exceed £#{MAXIMUM_BALANCE}." if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: Please top-up." if insufficient_funds?
    charge_penalty(station) if in_journey?
    self.journey = Journey.new
    journey.start(station)
  end

  def touch_out(station)
    if in_journey?
      journey.finish(station)
      deduct(journey.amount)
      log.add_trip(journey.current_trip)
      self.journey = nil
    else
      charge_penalty(station)
    end
  end

  private

  attr_writer :balance, :journey

  def charge_penalty(station)
    puts "Penalty Fare Deducted"
    deduct(PENALTY_FARE)
    in_journey? ? log.add_trip("tie at #{station}") : log.add_trip("toe at #{station}")
  end

  def deduct(amount)
    self.balance -= amount
  end

  def insufficient_funds?
    true if balance < MINIMUM_BALANCE
  end
end
