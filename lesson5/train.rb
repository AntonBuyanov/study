class Train
  include InstanceCounter
  include NameCompany
  attr_reader :speed, :number, :type, :route, :cur_station, :station, :van_list

  @@trains = []

  def self.find(number)
    @@trains.find{|n|n.number == number}
  end

    def initialize(number)
    @speed = 0
    @number = number
    @index_station = 0
    @van_list = []
    @@trains << self
    register_instance
    end

  def stop
    @speed = 0
  end

  def add_van(van)
    if van.type == @type
    @van_list << van
    else
      puts "Типы вагона/поезда не соответствуют"
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

  protected
  # поезд может набирать скорость только методом
  def speed_up(speed)
    @speed += speed
  end
end
