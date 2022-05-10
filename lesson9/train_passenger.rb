# frozen_string_literal: true

# Класс TrainPassenger наследуется от класса Train, имеет те же методы и атрибуты. Тип пассажирский.
class TrainPassenger < Train
  def initialize(number)
    super
    @type = 'пассажирский'
  end
end
