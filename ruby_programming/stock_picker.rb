def stock_picker(prices)
  pick = nil
  max_diff = 0
  prices.each_with_index do |price, idx|
    prices_after = prices.slice(idx..-1)
    
    break if not prices_after

    max = prices_after.max
    diff = max - price

    if diff > max_diff
      pick = [idx, prices.find_index(max)]
      max_diff = diff
    end
  end
  pick
end

