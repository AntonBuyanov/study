# frozen_string_literal: true

# подключение файлов
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'company_name'
require_relative 'accessors'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'route'
require_relative 'passenger_van'
require_relative 'cargo_van'
require_relative 'menu'

# test = RailwayStation.new
# test.menu

station1 = Station.new('Омск')
station1.value = 5
station1.value = 9
station1.value = 12
station1.accessors = 7
station1.accessors = 8
p station1.value_history
puts station1.valid?
train1 = Train.new('12332')
puts train1.valid?
train1.accessors = 7
train1.value = 8
train1.value = 9
train1.value = 10
p train1.value_history
