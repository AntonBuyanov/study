class PassengerVan
  include NameCompany
  attr_reader :type

  def initialize
    @type = "пассажирский"
  end
end
