class Node
  
  attr_accessor :value, :next_node

  def initialize(val=nil)
    @value = val
    @next_node = nil
  end
end

class LinkedList
  
  def initialize
    @first = nil
    @last = nil
    @size = 0
  end

  def init(value)
    @first = Node.new(value)
    @last = @first
    @size += 1
  end

  def insert_at(value, index)
    if index <= 0
      self.preppend(value)
    elsif index >= @size
      self.append(value)
    else
      prev = self.at(index-1)
      node = self.at(index)
      
      new_node = Node.new(value)
      new_node.next_node = node
      prev.next_node = new_node 

      @size += 1
    end
  end

  def remove_at(index)
    if index == 0
      @first = @first.next_node
    elsif index >= @size-2
      self.pop
    else
      prev_node = self.at(index-1)
      next_node = self.at(index+1)
      prev_node.next_node = next_node
      @size -= 1
    end
  end

  def append(value)
    if @size == 0
      self.init(value)
    else
      @last.next_node = Node.new(value)
      @last = @last.next_node
      @size += 1
    end
  end

  def preppend(value)
    if @size == 0
      self.init(value)
    else
      new_first = Node.new(value)
      new_first.next_node = @first
      @first = new_first
      @size += 1
    end
  end

  def head
    @first
  end

  def tail
    @last
  end

  def size
    @size
  end

  def at(index)
    traveler = @first
    
    while(index > 0) do
      traveler = traveler.next_node
      index -= 1
    end

    traveler
  end

  def find (value)
    index = 0
    traveler = @first
    while(traveler) do
      return index if traveler.value == value
      index += 1
      traveler = traveler.next_node
    end
    nil
  end

  def pop
    second_last = self.at(@size-2)
    second_last.next_node = nil
    @last = second_last
    @size -= 1
  end

  def contains?(value)
    traveler = @first
    while(traveler && traveler.value != value ) do
      traveler = traveler.next_node
    end
    (traveler && traveler.value == value)
  end

  def to_s
    traveler = @first
    while (traveler) do
      print "(#{traveler.value})->"
      traveler = traveler.next_node
    end
    print "(nil)"
  end
end

list = LinkedList.new
puts list.to_s

puts "#Append 2"
list.append(2)
puts list.to_s
puts " Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "#Append 3"
list.append(3)
puts list.to_s
puts " Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "#Preppend 1"
list.preppend(1)
puts list.to_s
puts " Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "#Pop"
list.pop
puts list.to_s
puts " Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "Contains 2? #{list.contains?(2)}"
puts "Find 2 at index #{list.find(2)}"

puts "#RemoveAt 2"
list.remove_at(1)
puts list.to_s
puts " Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "#InsertAt 2 the value of 3"
list.insert_at(3, 2)
puts list.to_s
puts "Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "#InsertAt 1 the value of 2"
list.insert_at(2, 1)
puts list.to_s
puts "Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"
