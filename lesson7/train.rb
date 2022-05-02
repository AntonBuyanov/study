class Train
  include InstanceCounter
  include NameCompany
  attr_accessor :route
  attr_reader :speed, :number, :type, :cur_station, :station, :van_list, :count_van

  NUMBER_FORMAT = /^[а-я1-9]{3}(-)?[а-я1-9]{2}/i

  @@trains = []

  def self.find(number)
    @@trains.find{ |n| n.number == number}
  end

  def initialize(number)
    @speed = 0
    @number = number
    @index_station = 0
    @van_list = []
    @@trains << self
    register_instance
    validate!
  end

  def stop
    @speed = 0
  end

  def add_van(van)
    if van.type == @type
      @van_list << van
    end
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
    van_list.each &block
  end

  def count_van
    van_list.size
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  # поезд может набирать скорость только методом
  def speed_up(speed)
    @speed += speed
  end

  def validate!
    raise "Номер поезда не может быть пустым!" if number.nil?
    raise "Формат номера поезда должен быть ХХХ-ХХ или ХХХХХ" if number !~ NUMBER_FORMAT
    true
  end
end
