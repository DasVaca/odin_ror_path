require_relative "custom_enumerable"
puts "my_each_with_index vs each_with_index"
n = [*1..5]
n.my_each_with_index { |o, i| puts "#{i}. #{o}" }
n.each_with_index {|o, i| puts "#{i}. #{o}" }
