require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'modules/accessors'

class Station
  include InstanceCounter
  include Accessors
  include Validation

  NAME_FORMAT = /^\S/

  attr_reader :name, :trains

  attr_accessor_with_history :first, :last
  strong_attr_accessor :strong, String

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    validate!
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
end
