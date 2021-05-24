require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(all_places)
    super(Wagon::TYPE[:PASSENGER], all_places)
  end

  def take_place
    if free_places >= 1 && @places_occupied < @all_places
      @places_occupied += 1
    else
      puts 'Извините, нет свобоодного места.'
    end
  end
end
