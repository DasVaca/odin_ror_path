require_relative 'custom_enumerable'

puts "my_inject vs inject"

n = *(1..10)

p n.my_inject(0) { |sum, item| sum + item}
p n.inject(0) { |sum, item| sum + item}

puts "test with multiply els"

def multiply_els (a)
  a.my_inject() { |acum, item| acum*item}
end

def multiply (a)
  a.inject() {|acum, item| acum * item}
end

p multiply_els [2, 4, 5]
p multiply [2, 4, 5]


