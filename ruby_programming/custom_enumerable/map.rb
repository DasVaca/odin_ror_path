require_relative "custom_enumerable"
puts "my_map vs map"
n = [*1..5]
p n.my_map { |item| item*2}
p n.map {|item| item*2}
