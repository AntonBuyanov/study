class Station
  attr_accessor :name
  def initialize(name)
    @name = name
    @train_list = []
  end

  def train_add(train) # принять поезд
    @train_list << train
  end

  def train_list # список поездов на станции
    p "Список всех поездов на станции: #{@train_list}"
  end

  def type_train(type) # список поездов по типу
    @train_list.select { |train| train.type =~ /#{type}/}
  end
end

class Train
  attr_accessor :speed
  attr_reader :number, :type, :count_van
  def initialize(speed = 0, number, type, count_van)
    @speed = speed
    @number = number
    @type = type
    @count_van = count_van
    @route = []
  end

  def speed_up(speed) # набирать скорость
    @speed += speed
  end

  def stop # тормозить
    @speed = 0
  end

  def current_speed # узнать текущую скорость
    @speed
  end

  def countvan # количество вагонов
    @count_van
  end

  def add_van # прицепить вагон
    @count_van += 1 if @speed == 0
  end

  def subtract_van # отцепить вагон
    @count_van -= 1 if @speed == 0
  end

  def take_a_route(route) # назначить маршрут
    @route << route
    p @route

  end
end

class Route
  attr_accessor :full_station
  def initialize (first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @full_station = [first_station.name, last_station.name]
    @intermediate = []
  end

  def add_intermediate(station)
    @full_station.insert(-2, station.name)
    @intermediate << station.name
    puts "Вы добавили промежуточную станцию, теперь полный маршрут: #{@full_station}"
  end

  def list_intermediate
    puts "Список промежуточных станций: #{@intermediate.to_s}"
  end

  def all_station
    puts "Список всех станций: #{@full_station}"
  end

  def del_intermediate
    puts "Вы удалили промежуточную станцию #{@full_station[-2]}"
    @full_station.delete_at(-2)
    @intermediate.delete_at(-1)
    puts "В маршруте остались города: #{@full_station}"
  end
end

train1 = Train.new(101, "пассажирский", 13)
train2 = Train.new(200, "грузовой", 30)
station1 = Station.new("Butovo")
station2 = Station.new("Sokolnikovo")
station3 = Station.new("Perm")
station4 = Station.new("Omsk")
station1.train_list
p station1.type_train("пассажирский")
train1.speed_up(50)

abakan = Route.new(station1, station2)
abakan.add_intermediate(station3)
abakan.add_intermediate(station4)
abakan.list_intermediate
train1.take_a_route(abakan)
