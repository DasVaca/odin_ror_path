module Enumerable
=begin
I did not wanted to make overcalls to others methods 
(ie. calling my_select from my_all?).
So there's not overcharge and hopefully best performance.
=end

  def crash? bg
    raise ArgumentError.new("No block given.") unless bg
  end

  def my_each
    crash? block_given?

    for item in self
        yield item
    end

    self
  end

  def my_each_with_index
    crash? block_given?
    
    i = 0
    
    self.my_each do |item|
      yield item, i
      i += 1
    end
  end

  def my_select
    crash? block_given?
    selected = []
    
    self.my_each do |item|
      selected << item if yield item
    end

    selected
  end
  
  def my_all?
    crash? block_given?
    
    for item in self
      return false unless yield item
    end

    return true
  end

  def my_any?
    crash? block_given?
    
    for item in self
      return true if yield item
    end

    return false
  end

  def my_none?
    crash? block_given?
    # Here I did call other methods, just to show the alternative idea
    self.my_select { |item| yield item}.size == 0
  end

  def my_count(it = nil)
    if it
      self.my_select {|item| item == it}.size
    elsif block_given?
      self.my_select {|item| yield item}.size
    else
      self.size
    end
  end

  def my_map (&proc_block)
    raise ArgumentError.new("No block or proc given") unless block_given? and proc_block
    mapped = []
    self.my_each do |item|
      v = nil
      if proc_block 
        v = proc_block.call(item)
      elsif block_given? 
        v = yield item
      end

      mapped << v
    end

    mapped
  end

  def my_inject (initial_val=nil)
    crash? block_given?

    acum = initial_val 

    self.my_each_with_index do |item, i|
      unless acum 
        acum = self.first
        next
      end
      acum = yield acum, item
    end
    
    acum
  end
end
