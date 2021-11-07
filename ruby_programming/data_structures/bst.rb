class Node
  
  include Comparable

  attr_reader :data
  attr_accessor :left, :right

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
    return nil unless root

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
          next
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
end


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
