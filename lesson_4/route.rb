class Route
  attr_reader :name, :stations

  def initialize(name, station_start, station_end)
    @name = name
    @stations = [station_start, station_end]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end