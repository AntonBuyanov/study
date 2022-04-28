class Route
  include InstanceCounter
  attr_accessor :full_station, :first_station

  def initialize (first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @full_station = [@first_station, @last_station]
    register_instance
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
