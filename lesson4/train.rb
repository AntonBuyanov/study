class Train

  attr_accessor :speed, :route, :van_list
  attr_reader :number, :type, :cur_station, :station

  def initialize(number)
    @speed = 0
    @number = number
    @index_station = 0
    @van_list = []
  end

  def stop
    @speed = 0
  end

  def add_van(van)
    @van_list << van
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

class PassengerTrain < Train

  def initialize(number)
    super
    @type = "пассажирский"
  end
end

class CargoTrain < Train

  def initialize(number)
    super
    @type = "грузовой"
  end
end
