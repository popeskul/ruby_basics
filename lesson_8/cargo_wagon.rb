require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(all_places)
    super(Wagon::TYPE[:CARGO], all_places)
  end

  def take_place(place)
    if free_places >= 1 && @places_occupied < @all_places
      @places_occupied += place
    else
      puts 'Извините, нет свобоодного места.'
    end
  end
end
