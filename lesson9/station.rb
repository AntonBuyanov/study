# frozen_string_literal: true

# Класс Station может создавать экземпляры станций. Имеет название, которое указывается при создании.
# Может принимать поезда, возвращаь список поездов на станции, список по типу поездов.
class Station
  include InstanceCounter
  include Validation
  extend Accessors
  attr_reader :train_list, :name

  attr_accessor_with_history :value, :accessors
  strong_attr_accessor(values: Integer)
  validate :name, :presence
  validate :name, :format, /^[А-ЯA-Z][а-яA-Z]+/.freeze
  validate :name, :type, String

  def initialize(name)
    @name = name
    @train_list = []
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

  def train_list_each
    train_list.each { |n| print "Номер поезда: #{n.number}, тип: #{n.type} \n" }
  end
end
