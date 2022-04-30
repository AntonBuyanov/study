class Station
  include InstanceCounter
  attr_reader :train_list, :name

  NAME_FORMAT = /^[А-ЯA-Z][а-яA-Z]+/

  @@stations = []

def self.all
  @@stations
end

def initialize(name)
  @name = name
  @train_list = []
  @@stations << self
  register_instance
  validate!
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Название станции не может быть пустым!" if name.nil?
    raise "Название станции не может содержать менее 2 символов" if name.length < 3
    raise "Название станции должно быть с заглавной буквы, и не должно содержать цифр и иных символов" if name !~ NAME_FORMAT
    true
  end
end
