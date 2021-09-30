require_relative "custom_enumerable"
puts "my_each vs each"
n = [*1..5]
n.my_each { |i| print "#{i} " }
puts ''
n.each {|i| print "#{i} " }
