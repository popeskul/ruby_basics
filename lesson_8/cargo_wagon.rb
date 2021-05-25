require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(all_places)
    super(Wagon::TYPE[:CARGO], all_places)
  end

  def take_place(place)
    @places_occupied += place if free_places >= 1 && @places_occupied < @all_places
  end
end
