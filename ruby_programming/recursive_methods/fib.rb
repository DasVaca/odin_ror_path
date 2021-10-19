def fibs(n)
  list = [1, 1]

  for i in 2..(n-1) do
    list << list[i-1] + list[i-2]
  end

  list
end

def fibs_rec(n)
  return [1, 1] if n == 2
  l = fibs_rec(n-1)
  l + [l[-2..].reduce(0, :+)]
end

puts "Iterative fib"
puts "12 -> #{fibs(12)}"
puts "4  -> #{fibs(4)}"

puts "Recursive fib"
puts "12 -> #{fibs_rec(12)}"
puts "4  -> #{fibs_rec(4)}"
