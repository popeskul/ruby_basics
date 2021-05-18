puts 'What is the basis?'
basis = gets.chomp.to_i

puts 'What height?'
height = gets.chomp.to_i

area_triangle =  1.0 / 2 * basis * height

puts "Result: #{area_triangle}"