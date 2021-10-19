def flatten (list, flat=[])
  for e in list do
    if e.is_a? Array
      flatten(e, flat)
    else
      flat << e
    end
  end
  flat
end

test = [[1,2], 3, 4, [5,6,[7,8]], 9, 10]

p flatten(test)
