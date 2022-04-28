class PassengerVan
  include NameCompany
  attr_reader :type

  def initialize
    @type = "пассажирский"
  end
end

van1 = PassengerVan.new
# p van1.type
