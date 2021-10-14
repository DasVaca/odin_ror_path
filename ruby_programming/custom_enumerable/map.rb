require_relative "custom_enumerable"
puts "my_map vs map"
puts "with block"
n = [*1..5]
p n.my_map { |item| item*2}
p n.map {|item| item*2}

puts "with proc"
pr = proc {|x| x*3}
p n.my_map(&pr)
p n.map(&pr)

