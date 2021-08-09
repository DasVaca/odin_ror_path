def substrings (src, dict)
  dict.reduce(Hash.new(0))do |result, word| 
    count = src.split.reduce(0) { |count, str| count + (str.include?(word) ? 1: 0) }
    result[word] = count if count > 0
    result
  end
end

d = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below the low", d)
