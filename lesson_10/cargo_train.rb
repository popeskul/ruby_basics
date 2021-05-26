require_relative 'train'
require_relative 'accessors'

class CargoTrain < Train
  include Accessors

  attr_accessor_with_history :first, :last
  strong_attr_accessor :strong, String

  def initialize(train_num)
    super(train_num, Train::TYPE[:CARGO])
  end
end
