require_relative 'train'

class PassengerTrain < Train
  def initialize(train_num)
    super(train_num, Train::TYPE[:PASSENGER])
  end
end
