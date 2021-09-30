require_relative "custom_enumerable"
puts "my_count vs count"
n = [*1..5]
p n.my_count { |item| item > 2}
p n.count {|item| item > 2}

p n.my_count 
p n.count

p n.my_count 1 
p n.count 1
