# type - cargo, passenger

class Train
  attr_reader :speed, :wagons

  def initialize(train_num, type)
    @train_num = train_num
    @type      = type
    @wagons    = []
    @speed     = 0
  end

  def gain_speed(speed)
    @speed += speed
  end

  def speed_stop
    @speed = 0
  end

  def add_wagon(wagon)
    speed_stop
    @wagons << wagon
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

  def route_station_next
    @route.stations[@station_index + 1]
  end

  def route_station_previous
    if @station_index > 0
      @route.stations[@station_index - 1]
    end
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
end