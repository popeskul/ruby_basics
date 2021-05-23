require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :name, :stations

  NAME_FORMAT = /^\S/

  def initialize(name, station_start, station_end)
    @name = name
    @stations = [station_start, station_end]
    validate?
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  private

  def validate?
    raise 'Имя должно состоять из одного символа и без пробелов' if name !~ NAME_FORMAT
  end
end
