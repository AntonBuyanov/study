# Класс Station может создавать экземпляры станций. Имеет название, которое указывается при создании.
# Может принимать поезда, возвращаь список поездов на станции, список по типу поездов.
class Station
  include InstanceCounter
  attr_reader :train_list, :name

  NAME_FORMAT = /^[А-ЯA-Z][а-яA-Z]+/.freeze

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

  def train_add(train)
    @train_list << train
  end

  def train_del(train)
    @train_list.delete(train)
  end

  def type_train(type)
    @train_list.select { |train| train.type =~ /#{type}/ }
  end

  def type_train_count(type)
    type_train(type).size
  end

  def method_train(&block)
    train_list.each(&block)
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Название станции не может быть пустым!' if name.nil?
    raise 'Название станции не может содержать менее 2 символов' if name.length < 3
    if name !~ NAME_FORMAT
      raise 'Название станции должно быть с заглавной буквы, и не должно содержать цифр и иных символов'
    end

    true
  end
end
