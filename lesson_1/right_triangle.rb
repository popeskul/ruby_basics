sides = []

puts 'Введите первую сторону треугольника'
sides << gets.chomp.to_f

puts 'Введите вторую сторону треугольника'
sides << gets.chomp.to_f

puts 'Введите третью сторону треугольника'
sides << gets.chomp.to_f

cathet_1, cathet2, hypotenuse = sides.sort

is_equilateral_triangle = sides.map { |i| i == hypotenuse.max }.all?

# теорема пифагора
if is_equilateral_triangle
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