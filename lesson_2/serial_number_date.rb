puts "Введите день месяца"
day_user = gets.chomp.to_i

puts "Введите месяц"
month_user = gets.chomp.to_i

puts "Введите год"
year_user = gets.chomp.to_i

months = [31, 28, 31, 31, 30, 31, 30, 31, 30, 31, 30, 31]

months.take(month_user - 1).each_with_index { |d, i|
  day_user += d if month_user - 1 > i
}

if (year_user % 400 == 0 || year_user % 4 == 0 && year_user % 100 != 0) && (month_user > 2 && day_user > 28)
  puts "Высокосный год"
  day_user += 1
else
  puts "Обычный год"
end

puts day_user
