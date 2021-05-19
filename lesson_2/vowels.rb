vowels = [ "a", "e", "i", "o", "u" ]
alphabet = Hash[(:a..:z).to_a.zip((1..26).to_a)]
include_vowels = alphabet.select { |letter, number| vowels.include?(letter.to_s) }
