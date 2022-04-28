class Station
  include InstanceCounter
  attr_reader :train_list, :name

  @@stations = []

def self.all
  @@stations
end

def initialize(name)
  @name = name
  @train_list = []
  @@stations << self
  register_instance
end

  def train_add(train) # принять поезд
    @train_list << train
  end

  def train_del(train)
    @train_list.delete(train)
  end

  def type_train(type) # список поездов по типу
    @train_list.select { |train| train.type =~ /#{type}/}
  end

  def type_train_count(type) # количество поездов по типу
    type_train(type).size
  end
end
