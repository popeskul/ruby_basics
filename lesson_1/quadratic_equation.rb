puts 'Введите коэффициента a'
coefficient_a = gets.to_f

puts 'Введите коэффициента b'
coefficient_b = gets.to_f

puts 'Введите коэффициента c'
coefficient_c = gets.to_f

discriminant = coefficient_b**2 - 4 * coefficient_a * coefficient_c
divider = 2 * coefficient_a

if discriminant > 0
  d_root = Math.sqrt(discriminant)
  puts "Дискриминант - #{discriminant}"
  puts "Корни уравнения x1 - #{(-coefficient_b + d_root) / divider}"
  puts "Корни уравнения x2 - #{(-coefficient_b - d_root) / divider}"
elsif discriminant == 0
  puts "Дискриминант = #{discriminant}"
  puts "x1 = x2 - #{-coefficient_b / divider}"
else discriminant < 0
  puts "Дискриминант - #{discriminant}"
  puts 'Нет корней'
end