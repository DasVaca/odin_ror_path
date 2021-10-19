def merge_sort(list)
  if list.size == 1
    return list
  end

  h = list.size/2
  left = merge_sort(list[...h])
  right = merge_sort(list[h..])
  
  merged = []

  l = 0
  r = 0
  loop do
    if left[l] > right[r]
      merged << right[r]
      r += 1
    else
      merged << left[l]
      l += 1
    end

    if l == left.size
      merged += right[r..]
      break
    elsif r == right.size
      merged += left[l..]
      break
    end
  end
  merged
end

puts "Merge sort"
list = [1, 5, 3, 2, 4]
puts "#{list}:#{merge_sort(list)}"
list = [1, -2, -4, 10, -100]
puts "#{list}:#{merge_sort(list)}"
