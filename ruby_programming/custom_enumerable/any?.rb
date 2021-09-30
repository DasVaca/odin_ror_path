require_relative "custom_enumerable"
puts "my_any vs any"
n = [*1..5]
p n.my_any? { |item| item > 2 }
p n.any? {|item| item > 2 }
