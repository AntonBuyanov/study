# 3. Заполнить массив числами фибоначчи до 100
array = [0, 1]
index = 0
number = 1
while number <= 100 do
  number += array[index].to_i
  if number >= 100
    break
  end
  array << number
  index += 1
end

puts array.to_s
