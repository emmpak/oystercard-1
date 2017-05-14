require 'smarter_csv'

class Station

attr_reader :name, :zone

  def initialize(name)
    @name = name
    @zone = lookup
  end

  private

  def lookup
    data = SmarterCSV.process('./TubeStations.csv')
    correct_zone = data.select { |hash| hash[:station] == name }
    raise "Station not found" if !correct_zone[0]
    correct_zone[0].values[1]
  end

end
