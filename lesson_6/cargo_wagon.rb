require_relative 'wagon'

class CargoWagon < Wagon
  def initialize
    super(Wagon::TYPE[:CARGO])
  end
end
