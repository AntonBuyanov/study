# Класс CargoVan может создавать экземпляры грузовых вагонов. Объем пространства вагона указывается при создании.
# Имеет номер (случайный), объем занятого пространства. Тип грузовой.
class CargoVan
  include NameCompany
  attr_reader :type, :number, :free_space, :space_take

  def initialize(free_space)
    @type = 'грузовой'
    @number = rand(1000)
    @free_space = free_space
    @space_take = 0
  end

  def take_the_space(count)
    @free_space -= count
    @space_take += count
  end
end
