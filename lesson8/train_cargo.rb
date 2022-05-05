# Класс TrainCargo наследуется от класса Train, имеет те же методы и атрибуты. Тип грузовой.
class TrainCargo < Train
  def initialize(number)
    super
    @type = 'грузовой'
  end
end
