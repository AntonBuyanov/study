# 2. Заполнить массив числами от 10 до 100 с шагом 5

array = []
number = 10

while number <= 100 do
  array << number
  number += 5
end

puts array.to_s
