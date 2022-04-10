# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

array = ("a" .. "z").to_a
number = 0
hash = {}
array.each{|x| hash[x] = number += 1}
hash.delete_if{|x| x[/[bcdfghjklmnpqrstvwxyz]/]}

puts hash

# или отфильтровать через .select :
# puts hash.select{|x| x[/[aeiou]/]}
