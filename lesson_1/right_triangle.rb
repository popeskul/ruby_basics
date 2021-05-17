puts "Введите первую сторону треугольника"
side_1 =  gets.chomp.to_f

puts "Введите вторую сторону треугольника"
side_2 =  gets.chomp.to_f

puts "Введите третью сторону треугольника"
side_3 =  gets.chomp.to_f

if side_1 >= side_2 && side_1 >= side_3
  hypotenuse = side_1
  cathet_1 = side_2
  cathet_2 = side_3
elsif side_2 >= side_1 && side_2 >= side_3
  hypotenuse = side_2
  cathet_1 = side_1
  cathet_2 = side_3
else
  hypotenuse = side_3
  cathet_1 = side_1
  cathet_2 = side_2
end

# теорема пифагора
if side_1 == side_2 && side_1 == side_3
  puts 'Ваш треугольник равносторонний'
elsif hypotenuse ** 2 == cathet_1 ** 2 + cathet_2 ** 2
  if cathet_1 == cathet_2
    puts 'Ваш треугольник прямоугольный и равнобедренный'
  else
    puts 'Ваш треугольник прямоугольный'
  end
elsif cathet_1 == cathet_2 || hypotenuse == cathet_1 || hypotenuse == cathet_2
  puts 'Ваш треугольник равнобедренный'
else
  puts 'Ваш треугольник не является равнобедренным'
end