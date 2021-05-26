require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include Manufacturer

  attr_reader :type_wagon, :all_places, :places_occupied

  WAGON_TYPE_FORMAT = /(cargo|passenger)/

  TYPE = { CARGO: 'cargo', PASSENGER: 'passenger' }.freeze

  def initialize(type_wagon, all_places)
    @type_wagon = type_wagon
    @all_places = all_places.to_i
    @places_occupied = 0
    validate?
  end

  def free_places
    @all_places - @places_occupied
  end

  private

  def validate?
    if @type_wagon !~ WAGON_TYPE_FORMAT
      raise ValidationError,
            'Ошибка! Введите корректный тип вагона: cargo или passenger'
    end
    raise ValidationError, 'Ошибка! Введите количество мест больше 0' if @all_places < 1
  end
end
