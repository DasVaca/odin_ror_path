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
    second_last = self.at(@size-1)
    second_last.next_node = nil
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

list.append(2)
puts list.to_s
puts "Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

list.append(3)
puts list.to_s
puts "Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

list.preppend(1)
puts list.to_s
puts "Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

list.pop
puts list.to_s
puts "Head: #{list.head.value}, Tail: #{list.tail.value}, Size: #{list.size}"

puts "Contains 3? #{list.contains?(3)}"
puts "Find 3 at index #{list.find(3)}"
