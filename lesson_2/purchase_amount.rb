shop = {}

puts 'Введите stop, чтобы прекратить добавление товара'
print 'Введите название товара: '
shop_name = gets.chomp

while shop_name != 'стоп'
  print 'Введите цену за единицу товара: '
  shop_price = gets.chomp.to_i

  print 'Введите количество купленного товара: '
  shop_quantity = gets.chomp.to_i

  shop[shop_name] = { price: shop_price, count: shop_quantity }

  print 'Введите название товара: '
  shop_name = gets.chomp
end

price_total = 0

shop.each do |k, v|
  local_price = v[:price] * v[:count]
  price_total += local_price
end

puts shop
puts "Итоговая сумма всех покупок: #{price_total}"
