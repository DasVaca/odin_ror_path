require_relative "custom_enumerable"
puts "my_select vs select"
n = [*1..5]
p n.my_select { |item| item > 2 }
p n.select {|item| item > 2 }
