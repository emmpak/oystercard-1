require 'smarter_csv'

class Station

attr_reader :name, :zone

  def initialize(name)
    @name = name
    @zone = lookup
  end

  #user enters station name as an argument, station class looks up zone in data variable

  def lookup
    data = SmarterCSV.process('./TubeStations.csv')

    # data.each do |hash|
    #   #is name the value of :station?
    #
    #   select hash[:station].include?(name)
    # end


    correct = data.select { |hash| hash[:station].include?(name) }
    correct[0].values[1]

  end


end
