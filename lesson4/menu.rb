class RailwayStation
  attr_reader :list_station, :list_route, :list_train

  def initialize
    @list_station = []
    @list_route = []
    @list_train = []
  end

  def menu
    loop do
      puts "Выберите действие:
1 - Создать станцию
2 - Создать поезд
3 - Создать маршрут и управлять станцией в нем (добавить удалить)
4 - Добавить/удалить промежуточную станцию
5 - Назначить маршрут поезду
6 - Добавить вагоны к поезду
7 - Отцепить вагоны от поезда
8 - Переместить поезд по маршруту вперед и назад
9 - Просмотреть список станций и список поездов на станции
закрыть - Выйти из программы"
      option = gets.chomp

      case option
      when "1"
        create_station
      when "2"
        create_train
      when "3"
        create_route
      when "4"
        intermediate_station
      when "5"
        train_route
      when "6"
        add_van
      when "7"
        substract_van
      when "8"
        move_station
      when "9"
        view_station_train
      when "закрыть"
        break
      end
    end
  end

  private

  def create_station
    puts "Введите название станции"
    name = gets.chomp
    list_station << Station.new(name)
  end

  def create_train
    puts "Введите номер поезда"
    number = gets.chomp
    puts "Введите тип поезда (пассажирский, грузовой)"
    type = gets.chomp
    if type == "пассажирский"
      @list_train << PassengerTrain.new(number)
    elsif type == "грузовой"
      @list_train << CargoTrain.new(number)
    else puts "Такого типа поезда нет"
    end
  end

  def create_route
    puts "Введите первую станцию в маршруте"
    first_station = gets.chomp
    puts "Введите вторую станцию в маршруте"
    last_station = gets.chomp
    @list_route << Route.new(name_station(first_station), name_station(last_station))
  end

  def intermediate_station
    puts "Выберите маршрут"
    index_route = gets.chomp.to_i
    route = @list_route[index_route]
    puts "Выберите действие:
1 - Добавить промежуточную станцию
2 - Удалить промежуточную станцию"
    option = gets.chomp
    case option
    when "1"
      puts "Введите название станции"
      station = gets.chomp
      route.add_intermediate(name_station(station))
    when "2"
      puts "Введите название станции"
      station = gets.chomp
      route.del_intermediate(name_station(station))
    end
  end

  def train_route
    puts "Введите индекс поезда"
    p @list_train
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    puts "Выберите машрут"
    p @list_route
    index_route = gets.chomp.to_i
    route = @list_route[index_route]
    train.take_a_route(route)
  end

  def add_van
    puts "Выберите вариант:
1 - Добавить вагон к пассажирскому поезду
2 - Добавить вагон к грузовому поезду"
    option = gets.chomp
    case option
    when "1"
      puts "Введите номер индекса поезда"
      p @list_train
      index_train = gets.chomp.to_i
      train = @list_train[index_train]
      train.add_van(PassengerVan.new)
    when "2"
      puts "Введите номер индекса поезда"
      p @list_train
      index_train = gets.chomp.to_i
      train = @list_train[index_train]
      train.add_van(@list_van << CargoVan.new)
    end
  end

  def substract_van
      puts "Введите номер индекса поезда"
      p @list_train
      index_train = gets.chomp.to_i
      train = @list_train[index_train]
      puts "Введите номер индекса вагона"
      index_van = gets.chomp.to_i
      van = train.van_list[index_van]
      train.subtract_van(van)
    end

  def move_station
    puts "Введите индекс поезда"
    p @list_train
    index_train = gets.chomp.to_i
    train = @list_train[index_train]
    puts "Выберите машрут"
    p @list_route
    index_route = gets.chomp.to_i
    route = @list_route[index_route]
    puts "Выберите действие:
1 - Переместить вперед
2 - Переместить назад"
    option = gets.chomp
    case option
    when "1"
      train.move_next_station(route)
    when "2"
      train.move_prev_station(route)
    end
  end

  def view_station_train
    p Station.station_list{|n|puts n.name}
  end

  def name_station(name_station)
    @list_station.find {|n|n.name == name_station}
  end
end
