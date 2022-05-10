# frozen_string_literal: true

# Модуль NameCompany может создавать имя компании-производителя. Подключается в классах поездов и вагонов.
module NameCompany
  attr_reader :name_company

  def company_name(name_company)
    @name_company = name_company
  end
end
