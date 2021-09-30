require_relative "custom_enumerable"
puts "my_all vs all"
n = [*1..5]
p n.my_all? { |item| item > 2 }
p n.all? {|item| item > 2 }
