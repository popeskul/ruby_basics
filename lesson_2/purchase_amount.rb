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

price_total = shop.reduce(0) do |sum, (_, itemDetails)|
  local_price = itemDetails[:price] * itemDetails[:count]
  sum += local_price
end

puts shop
puts "Итоговая сумма всех покупок: #{price_total}"
