def bubble_sort(array)
  loop do
    swap = false

    for i in (0...array.count-1) do
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        swap = true
      end
    end

    break if not swap
  end
  array
end

p bubble_sort([4,3,78,2,0,2])
