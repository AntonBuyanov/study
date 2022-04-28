class CargoVan
  include NameCompany
  attr_reader :type

  def initialize
    @type = "грузовой"
  end
end
