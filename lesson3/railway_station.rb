class Station
  attr_accessor :name
  attr_reader :train_list
  def initialize(name)
    @name = name
    @train_list = []
    @train_type = Hash.new(0)
  end

  def train_add(train) # принять поезд
    @train_list << train
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
  attr_accessor :speed
  attr_reader :number, :type, :count_van, :cur_station
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
    @cur_station = route.first_station
    @cur_station.train_add(self)
  end

  def next_station(route) # перемещение по станциям(вперед)
    @index_station += 1
    @cur_station = route.full_station[@index_station]
  end

  def prev_station(route) # перемещение по станциям(назад)
    @index_station -= 1
    @cur_station = route.full_station[@index_station]
  end

  def next_station_put(route)
    @index_station += 1
    puts @cur_station = route.full_station[@index_station]
  end
end

class Route
  attr_accessor :full_station
  attr_reader :intermediate, :first_station
  def initialize (first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate = []
    @full_station = [@first_station, @intermediate, @last_station].flatten
  end

  def add_intermediate(station) # добавить промежуточную станцию
    @intermediate << station
    puts "Вы добавили промежуточную станцию #{station.name}, теперь полный маршрут: #{full_station}"
  end

  def all_station
    puts "Список всех станций: #{full_station}" # станции маршрута
  end

  def del_intermediate(station)
    puts "Вы удалили промежуточную станцию #{station.name}" # удалить промежуточную станцию
    @intermediate.delete(station)
    puts "В маршруте остались станции: #{full_station}"
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
# station4.type_train_count
# abakan.list_intermediate
# train1.take_a_route(abakan)
# abakan.add_intermediate(station4)
abakan.add_intermediate(station3)
abakan.add_intermediate(station4)
# train1.take_a_route(abakan)
# puts abakan.full_station
# train1.next_station_put(abakan)
abakan.full_station
abakan.intermediate
