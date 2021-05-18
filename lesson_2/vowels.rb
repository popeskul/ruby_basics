vowels = [ "a", "e", "i", "o", "u" ]
symbol_az = Hash[(:a..:z).to_a.zip((1..26).to_a)].select do |letter, number| 
  vowels.include?(letter.to_s)
end
