require_relative 'train'

class CargoTrain < Train
  def initialize(train_num)
    super(train_num, Train::TYPE[:CARGO])
  end
end
