require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include Manufacturer
  
  attr_reader :type_wagon

  WAGON_TYPE_FORMAT = /(cargo|passenger)/

  TYPE = { CARGO: 'cargo', PASSENGER: 'passenger' }

  def initialize(type_wagon)
    @type_wagon = type_wagon
    validate?
  end

  def validate?
    raise ValidationError 'Ошибка! Введите корректный тип вагона: cargo или passenger' if type_train !~ WAGON_TYPE_FORMAT
  end
end
