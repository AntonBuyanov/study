class PassengerVan
  attr_reader :type

  def initialize
    @type = "пассажирский"
  end
end

class CargoVan
  attr_reader :type

  def initialize
    @type = "грузовой"
  end
end
