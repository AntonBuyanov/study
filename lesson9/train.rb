# frozen_string_literal: true

# Клас Train может создавать экземпляры поездов. Каждый поезд имеет номер, который указывается при создании.
# Может набирать скорость, тормозить, возвращать скорость, возвращать список вагонов, количество.
# Может прицеплять/отцеплять вагоны.
# Может принимать маршрут, перемещаться между станциями, вовзращать текущую/следующую/предыдущую станции
class Train
  include InstanceCounter
  include NameCompany
  include Validation
  extend Accessors
  attr_accessor :route
  attr_reader :speed, :number, :type, :cur_station, :station, :van_list, :count_van

  attr_accessor_with_history :value, :accessors
  strong_attr_accessor(values: Integer)
  validate :number, :format, /^[а-я1-9]{3}(-)?[а-я1-9]{2}/i.freeze

  def initialize(number)
    @speed = 0
    @number = number
    @index_station = 0
    @van_list = []
    register_instance
    validate!
  end

  def stop
    @speed = 0
  end

  def add_van(van)
    @van_list << van if van.type == @type
  end

  def subtract_van(van)
    @van_list.delete(van)
  end

  def take_a_route(route)
    self.route = route
    @cur_station = route.first_station
    @cur_station.train_add(self)
  end

  def move_next_station(route)
    @cur_station.train_del(self)
    @index_station += 1
    @cur_station = route.full_station[@index_station]
  end

  def move_prev_station(route)
    @cur_station.train_del(self)
    @index_station -= 1
    @cur_station = route.full_station[@index_station]
  end

  def info_next_station
    route.full_station[@index_station + 1]
  end

  def info_prev_station
    route.full_station[@index_station - 1]
  end

  def method_van(&block)
    van_list.each(&block)
  end

  protected

  def speed_up(speed)
    @speed += speed
  end
end
