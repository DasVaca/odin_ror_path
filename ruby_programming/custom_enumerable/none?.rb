require_relative "custom_enumerable"
puts "my_none vs none"
n = [*1..5]
p n.my_none? { |item| item < 0}
p n.none? {|item| item < 0}
