class Node
  
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  
  def initialize(array)
    @root = self.build_tree(array)
  end

  def build_tree(array)
    return nil unless array
    build_tree_recursive(array.uniq.sort)
  end

  def build_tree_recursive(array)
    return nil if array.size == 0 
    root = Node.new(array[array.size / 2])
    root.left  = build_tree_recursive(array[...array.size/2])
    root.right = build_tree_recursive(array[array.size/2 + 1..])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end 

  def find(data, root=@root)
    if root.nil?
      raise ArgumentError("#{data} not found.")
    end

    if root.data == data
      root
    elsif data < root.data
      self.find(data, root=root.left)
    else
      self.find(data, root=root.right)
    end
  end

  def insert(data)
    root = @root
    loop do
      break if data == root.data

      if data < root.data
        if root.left
          root = root.left
        else
          root.left = Node.new(data)
          break
        end
      else
        if root.right
          root = root.right
        else
          root.right = Node.new(data)
          break
        end
      end
    end
  end

  def direct_leaves(node)
    "" + "L"*(_to_i(node.left)) + "R"*(_to_i(node.right))
  end

  def _to_i(bool)
    (bool ? 1: 0)
  end

  def delete(data)
    # look for node
    parent = @root
    node = @root
    right_child = nil 
    loop do
      if data == node.data
        leaves = direct_leaves(node)

        if leaves == "LR"
          if node.right.left
            node.data = node.right.left.data
            node.right.left = nil
          else
            @root = @root.data == node.data ? node.right : @root; 
            parent.right = node.right
            node.right.left = node.left
            node = node.right
          end
        else
          if right_child
            parent.right = leaves == "R" ? node.right: node.left
          else
            parent.left = leaves == "R" ? node.right: node.left
          end
        end
        break
      else 
        parent = node
        node = node.data < data ? node.right: node.left
        right_child = parent.right == node
      end
    end
  end
  
  def get_level_order_queue(root=@root)
    queue = [root]

    for node in queue do
      queue << node.left if node.left
      queue << node.right if node.right
    end
    
    queue
  end

  def get_inorder_queue(root=@root)
    left = root.left ? get_inorder_queue(root.left): []
    right = root.right ? get_inorder_queue(root.right):[] 

    left << root 
    left.concat right

    left
  end

  def get_postorder_queue(root=@root)
    left = root.left ? get_postorder_queue(root.left): []
    right = root.right ? get_postorder_queue(root.right):[] 

    left.concat right
    left << root 

    left
  end

  def get_preorder_queue(root=@root)
    queue = [root]

    queue.concat (root.left ? get_preorder_queue(root.left): []) 
    queue.concat (root.right ? get_preorder_queue(root.right): [])
    
    queue
  end


  def yield_array_or_return(array, &block)
    if block
      array.each {|a| block.call(a)}
    else
      array
    end
  end

  def level_order(&block)
    yield_array_or_return(get_level_order_queue(), &block)
  end

  def inorder(&block)
    yield_array_or_return(get_inorder_queue(), &block)
  end

  def preorder(&block)
    yield_array_or_return(get_preorder_queue(), &block)
  end

  def postorder(&block)
    yield_array_or_return(get_postorder_queue(), &block)
  end

  def max_path_down_to(from, to, count=0)
    return count-1 if from.nil?
    
    if to.nil?
      left_count = max_path_down_to(from.left, to, count + 1)
      right_count = max_path_down_to(from.right, to, count + 1)
      return (left_count > right_count ? left_count : right_count)
    else
      return count if from.data == to.data
      from = from.data > to.data ? from.left: from.right
      self.max_path_down_to(from, to, count + 1)
    end
  end

  def height(data)
    node = self.find(data)

    max_path_down_to(node, nil)
  end

  def depth(data)
    traveler = @root
    edges_count = 0
    while !traveler.nil? && traveler.data != data do
      traveler = (traveler.data > data ? traveler.left: traveler.right)
      edges_count += 1
    end
    edges_count
  end

  def balanced?(root=@root)
    return true if root.nil?

    left = self.max_path_down_to(root.left, nil)
    right = self.max_path_down_to(root.right, nil)

    (left - right).abs > 1 ? false : self.balanced?(root.right) && self.balanced?(root.left)
  end
end

# ************************
#           TEST
# ***********************
a = [1, 2, 4, 5, 8, 9, 10]
t = Tree.new(a)
puts "Building tree with #{a}"
t.pretty_print
puts "Insert 3"
t.insert(3)
t.pretty_print
puts "Delete 3 (no child test)"
t.delete(3)
t.pretty_print
puts "Delete 4 (left child test)"
puts "Insert 3"
t.insert(3)
t.pretty_print
t.delete(4)
t.pretty_print
puts "Delete 5 (both child test - replace with left)"
t.delete(5)
t.pretty_print
puts "Delete 8 (both child test - replace with right)"
t.delete(8)
t.pretty_print

puts "Level order"
puts "Without block:"
p t.level_order.map {|n| n.data}
puts "With    block: "
t.level_order {|node| print "#{node.data} "}

puts "\nPreorder"
puts "Without block:"
p t.preorder.map {|n| n.data}
puts "With    block:"
t.preorder {|n| print "#{n.data} "}

puts "\nInorder"
puts "Without block:"
p t.inorder.map {|n| n.data}
puts "With    block:"
t.inorder {|n| print "#{n.data} "}

puts "\nPostorder"
puts "Without block:"
p t.postorder.map {|n| n.data}
puts "With    block:"
t.postorder {|n| print "#{n.data} "}

puts "\nHeight method"
t.insert(11)
t.insert(12)
t.insert(17)
t.insert(19)
t.pretty_print
p "Height of 12: #{t.height(12)}"
p "Height of 10: #{t.height(10)}"

puts "\nDepth method"
p "Depth of 19: #{t.depth(19)}"
p "Depth of  1: #{t.depth(1)}"

puts "\nBalanced"
t.pretty_print
p "Is balanced? #{t.balanced?}"
t.delete(11)
t.delete(12)
t.delete(17)
t.delete(19)
t.pretty_print
p "Is balanced? #{t.balanced?}"
