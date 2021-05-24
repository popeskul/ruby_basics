require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  
  attr_reader :name, :trains

  NAME_FORMAT = /^\S/

  @@all_stations = []

  def initialize(name)
    @name = name
    validate?
    @trains = []
    @@all_stations << self
    register_instance
  end

  def self.all
    # ObjectSpace.each_object(self).to_a - alternative solution
    @@all_stations
  end

  def add_train(train)
    @trains << train
  end

  def find_trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  private

  def validate?
    raise ValidationError 'Имя должно состоять из одного символа и без пробелов' if name !~ NAME_FORMAT
  end
end
