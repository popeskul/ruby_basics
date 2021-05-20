class Wagon
  attr_reader :type_wagon

  TYPE = { CARGO: 'cargo', PASSENGER: 'passenger' }

  def initialize(type_wagon)
    @type_wagon = type_wagon
  end
end
