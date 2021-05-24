require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :speed, :wagons, :train_num
  
  TYPE = { CARGO: 'cargo', PASSENGER: 'passenger' }

  TRAIN_NUM_FORMAT = /^\w{3}[- ]\w{2}/
  TRAIN_TYPE_FORMAT = /(cargo|passenger)/

  @@trains = []

  def initialize(train_num, type_train)
    @train_num  = train_num
    @type_train = type_train
    validate?
    @wagons     = []
    @speed      = 0
    @@trains << self
    register_instance
  end

  def self.find(train_num)
    @@trains.select { |train| train.train_num == @train_num }
  end

  def gain_speed(speed)
    @speed += speed
  end

  def speed_stop
    @speed = 0
  end

  def add_wagon(wagon)
    speed_stop
    @wagons << wagon if wagon.type_wagon == @type_train
  end

  def delete_wagon(wagon)
    speed_stop
    @wagons.delete(wagon)
  end

  def add_route(route)
    @route = route
    @station_index = 0
    @route.stations[@station_index].add_train(self)
  end

  def current_station
    @route.stations[@station_index]
  end

  def route_shift_forward
    if route_station_next
      current_station.send_train(self)
      @station_index += 1
      current_station.add_train(self)
    end
  end

  def route_shift_backward
    if route_station_previous
      current_station.send_train(self)
      @station_index -= 1
      current_station.add_train(self)
    end
  end

  def each_wagon
    if block_given?
      @wagons.each do |wagon|
        yield(wagon)
      end
    else
      puts 'Ошибка'
    end
  end

  private
  
  def route_station_next
    @route.stations[@station_index + 1]
  end

  def route_station_previous
    if @station_index > 0
      @route.stations[@station_index - 1]
    end
  end

  def validate?
    raise ValidationError, 'Ошибка! Введите номер поезда в таком формате: три буквы/три цифры, проблем или дефис и две буквы/дву цифры' if @train_num !~ TRAIN_NUM_FORMAT
    raise ValidationError, 'Ошибка! Введите корректный тип поезда: cargo или passenger' if @type_train !~ TRAIN_TYPE_FORMAT
  end
end
