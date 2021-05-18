puts "Введите день месяца"
day_user = gets.chomp.to_i

puts "Введите месяц"
month_user = gets.chomp.to_i

puts "Введите год"
year_user = gets.chomp.to_i

is_leap_year = year_user % 400 == 0 || year_user % 4 == 0 && year_user % 100 != 0;
febraury = is_leap_year ? 29 : 28

months = [31, febraury, 31, 31, 30, 31, 30, 31, 30, 31, 30, 31]

day_user = months.take(month_user).sum

puts is_leap_year ? "Высокосный год" : "Обычный год"

puts day_user
