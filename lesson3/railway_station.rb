class Station
  attr_reader :train_list, :name
  def initialize(name)
    @name = name
    @train_list = []
    @train_type = Hash.new(0)
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

  def type_train_count # количество поездов по типу
    @train_list.each { |train| @train_type[train.type] += 1}
    @train_type.each {|train, count| puts train + " " + count.to_s}
  end
end

class Train
  attr_accessor :speed, :route
  attr_reader :number, :type, :count_van, :cur_station, :station
  def initialize(speed = 0, number, type, count_van)
    @speed = speed
    @number = number
    @type = type
    @count_van = count_van
    @index_station = 0
  end

  def speed_up(speed) # набирать скорость
    @speed += speed
  end

  def stop # тормозить
    @speed = 0
  end

  def add_van # прицепить вагон
    @count_van += 1 if @speed == 0
  end

  def subtract_van # отцепить вагон
    @count_van -= 1 if @speed == 0
  end

  def take_a_route(route) # назначить маршрут
    self.route = route
    @cur_station = route.first_station
    @cur_station.train_add(self)
  end

  def next_station(route) # перемещение по станциям(вперед)
    @cur_station.train_del(self)
    @index_station += 1
    @cur_station = route.full_station[@index_station]
    @cur_station.train_add(self)
  end

  def prev_station(route) # перемещение по станциям(назад)
    @cur_station.train_del(self)
    @index_station -= 1
    @cur_station = route.full_station[@index_station]
    @cur_station.train_add(self)
  end

  def info_station # проверить текущую, следующую, предыдущую станцию
    puts cur_station
    puts route.full_station[@index_station + 1]
    puts route.full_station[@index_station - 1]
  end
end

class Route
  attr_reader :full_station, :first_station
  def initialize (first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @full_station = [@first_station, @last_station]
  end

  def add_intermediate(station) # добавить промежуточную станцию
    @full_station.insert(-2, station)
  end

  def intermediate_station # список промежуточных станций
    @full_station[1 .. -2]
  end

  def del_intermediate(station) # удалить промежуточную станцию
    if [full_station.first, full_station.last].include?(station)
      puts "Нельзя удалить первую и последнюю станции маршрута"
      else @full_station.delete(station)
    end
  end
end


train1 = Train.new(101, "пассажирский", 13)
train2 = Train.new(200, "грузовой", 30)
train3 = Train.new(300, "грузовой", 9)
station1 = Station.new("Butovo")
station2 = Station.new("Sokolnikovo")
station3 = Station.new("Perm")
station4 = Station.new("Omsk")
abakan = Route.new(station1, station2)
abakan.add_intermediate(station3)
abakan.add_intermediate(station4)
train1.take_a_route(abakan)
abakan.full_station
train1.next_station(abakan)
train1.info_station
