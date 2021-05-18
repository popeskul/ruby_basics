vowels = [ "a", "e", "i", "o", "u" ]
symbol_AZ = Hash[(:a..:z).to_a.zip((1..26).to_a)].select { |k,v| vowels.include?(k.to_s) }
