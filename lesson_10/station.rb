require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  NAME_FORMAT = /^\S/

  def initialize(name)
    @name = name
    validate?
    @trains = []
    self.class.all ||= []
    self.class.all << self
    register_instance
  end

  def self.all
    @all ||= []
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

  def each_train(&block)
    @trains.each(&block) if block_given?
  end

  private

  def validate?
    raise ValidationError, 'Ошибка! Имя должно состоять из одного символа и без пробелов' if @name !~ NAME_FORMAT
  end
end
