require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(all_places)
    super(Wagon::TYPE[:PASSENGER], all_places)
  end

  def take_place
    @places_occupied += 1 if free_places >= 1 && @places_occupied < @all_places
  end
end
