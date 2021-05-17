puts "Hello friend!"
puts "What is your name?"
username = gets.chomp

puts "What is your height?"
user_height = gets.chomp

puts "Name: #{username.capitalize}"

calculate_perfect_weight = (user_height.to_i - 110) * 1.15

perfect_weight = 
  if calculate_perfect_weight > 0
    calculate_perfect_weight.to_i
  else 
    "You are at your ideal weight"
  end

puts "Ideal weight: #{perfect_weight}"