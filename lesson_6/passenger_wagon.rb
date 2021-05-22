require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize
    super(Wagon::TYPE[:PASSENGER])
  end
end
