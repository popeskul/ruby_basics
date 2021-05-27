require_relative 'modules/manufacturer'
require_relative 'modules/validation'

class Wagon
  include Manufacturer
  include Validation

  WAGON_TYPE_FORMAT = /(cargo|passenger)/
  ALL_PLACES_FORMAT = /^[1-9][0-9]*$/
  TYPE = { CARGO: 'cargo', PASSENGER: 'passenger' }.freeze

  attr_reader :type_wagon, :all_places, :places_occupied

  validate :type_wagon, :presence
  validate :type_wagon, :format, WAGON_TYPE_FORMAT

  validate :all_places, :presence
  validate :all_places, :format, ALL_PLACES_FORMAT

  def initialize(type_wagon, all_places)
    @type_wagon = type_wagon
    @all_places = all_places.to_i
    validate!
    @places_occupied = 0
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
