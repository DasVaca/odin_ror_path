class Node
  
  include Comparable

  attr_reader :data
  attr_accessor :left_node, :right_node

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end
end

class Tree
  
  def initialize(array)
    @root = self.build_tree(array)
  end

  def build_tree(array)
    return nil unless array
    array = array.uniq.sort
    build_tree_recursive(array)
  end

  def build_tree_recursive(array)
    return nil if array.size == 0 
    p array
    root = Node.new(array[array.size / 2])
    root.left_node  = build_tree_recursive(array[...array.size/2])
    root.right_node = build_tree_recursive(array[array.size/2 + 1..])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end 
end

a = Array.new(15) { rand(1..100) }
Tree.new(a).pretty_print
