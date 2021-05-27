require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Route
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^\S/

  attr_reader :name, :stations

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name, station_start, station_end)
    @name = name
    @stations = [station_start, station_end]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
