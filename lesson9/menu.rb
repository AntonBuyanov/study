# frozen_string_literal: true

# Класс RailwayStation создает пользовательский текстовый интерфейс. С помощью него можно управлять всей системой
# жд станции
class RailwayStation
  attr_reader :list_station, :list_route, :list_train, :list_van

  def initialize
    @list_station = []
    @list_route = []
    @list_train = []
    @list_van = []
  end

  MENU = 'Выберите действие:
1 - Создать станцию
2 - Создать поезд
3 - Создать маршрут
4 - Добавить/удалить промежуточную станцию
5 - Назначить маршрут поезду
6 - Добавить вагоны к поезду
7 - Отцепить вагоны от поезда
8 - Занять место/объем в вагоне
9 - Переместить поезд по маршруту вперед и назад
10 - Посмотреть список вагонов у поезда
11 - Посмотреть список поездов на станции
12 - Просмотреть список станций и список поездов на станции
закрыть - Выйти из программы'

  def menu
    menu =
      { '1' => proc { create_station }, '2' => proc { create_train }, '3' => proc { create_route },
        '4' => proc { intermediate_station }, '5' => proc { train_route }, '6' => proc { add_van },
        '7' => proc { substract_van }, '8' => proc { take_place_space }, '9' => proc { move_station },
        '10' => proc { check_list_van }, '11' => proc { check_list_train }, '12' => proc { view_station_train } }
    loop do
      puts MENU
      option = gets.chomp
      break if option == 'закрыть'

      menu[option].call
    end
  end

  private

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    @list_station << Station.new(name)
    puts "Создана станция под названием: #{@list_station.last.name}"
  rescue RuntimeError => e
    puts "Введите заново название станции, #{e}"
    retry
  end

  def create_train
    puts 'Введите номер поезда'
    number = gets.chomp
    puts 'Введите тип поезда (пассажирский, грузовой)'
    type = gets.chomp
    case type
    when 'пассажирский'
      @list_train << TrainPassenger.new(number)
      puts "Создан #{type} поезд под номером: #{@list_train.last.number}"
    when 'грузовой'
      @list_train << TrainCargo.new(number)
      puts "Создан #{type} поезд под номером: #{@list_train.last.number}"
    else
      puts 'Такого типа поезда нет'
    end
  rescue RuntimeError => e
    puts "Введите заново параметры поезда, #{e}"
    retry
  end

  def create_route
    puts 'Введите первую и вторую станцию в маршруте'
    first_station = gets.chomp
    last_station = gets.chomp
    @list_route << Route.new(name_station(first_station), name_station(last_station))
    puts "Создан маршрут: #{@list_route.last.first_station.name} - #{@list_route.last.last_station.name}"
  end

  def intermediate_station
    @list_route.each { |n| print n.first_station.name, '-', n.last_station.name, ' ', "\n" }
    puts 'Введите индекс маршрута'
    index_route = gets.chomp.to_i
    route = @list_route[index_route]
    puts "Выберите действие:
1 - Добавить промежуточную станцию
2 - Удалить промежуточную станцию"
    option = gets.chomp
    puts 'Введите название станции'
    station = gets.chomp
    case option
    when '1'
      route.add_intermediate(name_station(station))
      puts "Вы добавили промежуточную станцию #{station}, теперь полный маршрут: "
      route.full_station.each { |m| print m.name, '-' }
    when '2'
      route.del_intermediate(name_station(station))
      puts "Вы добавили промежуточную станцию #{station}, теперь полный маршрут: "
      route.full_station.each { |m| print m.name, '-' }
    end
  end

  def train_route
    puts 'Введите индекс поезда'
    @list_train.each { |n| print n.number, '-', n.type, "\n" }
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    @list_route.each { |n| print n.first_station.name, '-', n.last_station.name, ' ', "\n" }
    puts 'Введите индекс маршрута'
    index_route = gets.chomp.to_i
    route = @list_route[index_route]
    train.take_a_route(route)
    puts "Поезду №#{train.number} назначен маршрут #{route.first_station.name} - #{route.last_station.name}"
  end

  def add_van
    puts 'Введите индекс поезда, к которому нужно прицепить вагон'
    @list_train.each { |n| print n.number, '-', n.type, "\n" }
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    case train.type
    when 'пассажирский'
      puts 'Введите общее количество мест в вагоне'
      place = gets.chomp.to_i
      @list_van << train.add_van(PassengerVan.new(place))
      puts "К поезду №#{train.number}-#{train.type} добавлен #{train.type} вагон"
    when 'грузовой'
      puts 'Введите количество общего объема грузового вагона'
      space = gets.chomp.to_i
      @list_van << train.add_van(CargoVan.new(space))
      puts "К поезду №#{train.number}-#{train.type} добавлен #{train.type} вагон"
    else
      puts 'Невозможно прицепить вагон к такому типу поезда'
    end
  end

  def substract_van
    puts 'Введите индекс поезда, от которого нужно отцепить вагон'
    @list_train.each { |n| print n.number, '-', n.type, "\n" }
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    puts 'Введите номер индекса вагона'
    train.van_list.each { |n| print n.type, ' ', n.number, "\n" }
    index_van = gets.chomp.to_i
    van = train.van_list[index_van]
    train.subtract_van(van)
    puts "От поезда №#{train.number}-#{train.type} отцеплен #{van.type} вагон №#{van.number}"
  end

  def take_place_space
    puts 'Выберите вагон'
    list_van.flatten.each { |n| print n.number, '-', n.type, "\n" }
    index_van = gets.chomp.to_i
    van = list_van.flatten[index_van]
    case van.type
    when 'пассажирский'
      van.take_the_place
      puts "В вагоне №#{van.number} занято 1 место, свободных мест осталось: #{van.place}"
    when 'грузовой'
      puts 'Введите количество объема, которое нужно занять'
      space = gets.chomp.to_i
      van.take_the_space(space)
      puts "В вагоне №#{van.number} занято #{space} объема, свободного осталось: #{van.free_space}"
    end
  end

  def move_station
    puts 'Введите индекс поезда'
    @list_train.each { |n| print n.number, '-', n.type, "\n" }
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    @list_route.each { |n| print n.first_station.name, '-', n.last_station.name, ' ', "\n" }
    puts 'Введите индекс маршрута'
    index_route = gets.chomp.to_i
    puts "Текущая станция: #{train.cur_station.name}, следующая: #{train.info_next_station.name},
предыдущая: #{train.info_prev_station.name}"
    route = @list_route[index_route]
    puts 'Выберите действие: 1 - Переместить вперед, 2 - Переместить назад'
    option = gets.chomp
    case option
    when '1'
      train.move_next_station(route)
      puts 'Поезд перемещен на следующую станцию'
    when '2'
      train.move_prev_station(route)
      puts 'Поезд перемещен на предыдущую станцию'
    end
  end

  def check_list_van
    puts 'Введите индекс поезда'
    @list_train.each { |n| print n.number, '-', n.type, "\n" }
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    case train.type
    when 'пассажирский'
      train.method_van do |n|
        puts "Вагон №#{n.number}, тип: #{n.type}, свободные места: #{n.place}, занятые места: #{n.place_take}"
      end
    when 'грузовой'
      train.method_van do |n|
        puts "Вагон №#{n.number}, тип: #{n.type}, доступный объем: #{n.free_space}, занятый объем: #{n.space_take}"
      end
    else
      puts 'Нет информации по этому типу поезда'
    end
  end

  def check_list_train
    @list_station.each { |n| puts n.name }
    puts 'Выберите станцию, введите название:'
    station = gets.chomp
    name_station(station).method_train do |n|
      puts "номер поезда: #{n.number}, тип: #{n.type} ,количество вагонов: #{n.van_list.size}"
    end
  end

  def view_station_train
    Station.all.each do |n|
      puts "Станция #{n.name}, поезда на станции:"
      n.train_list_each
    end
  end

  def name_station(name_station)
    @list_station.find { |n| n.name == name_station }
  end
end
