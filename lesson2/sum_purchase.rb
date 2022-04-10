# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во
# купленного товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор,
# пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

hash = Hash.new
all_hash = Hash.new
s = 0
sum = 0
loop do
  puts "Введите поочередно название товара, цену за единицу и количество купленного товара"
  product = gets.chomp
  if product == "стоп"
    all_hash.delete("стоп")
    puts all_hash
    puts "Сумма всех покупок: #{sum}"
    break
  end
  price = gets.chomp.to_i
  count = gets.chomp.to_i
  hash[price] = count
  all_hash[product] = hash
  s = price * count
  sum += s
  puts all_hash
  puts "#{product} вам обошелся: #{s}"
  puts "Сумма всех покупок: #{sum}"
end

