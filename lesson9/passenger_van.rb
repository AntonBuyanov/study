# frozen_string_literal: true

# Класс PassengerVan может создавать экземпляры пассажирских вагонов. Количество мест указывается при создании.
# Имеет номер (случайный), количество занятых мест. Тип пассажирский.
class PassengerVan
  include NameCompany
  attr_reader :type, :number, :place, :place_take

  def initialize(place)
    @type = 'пассажирский'
    @number = rand(1000)
    @place = place
    @place_take = 0
  end

  def take_the_place
    @place -= 1
    @place_take += 1
  end
end
