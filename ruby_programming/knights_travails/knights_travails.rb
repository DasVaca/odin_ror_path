class KnightNode
  attr_accessor :position, :neighbors

  def initialize(position)
    @position = position
    @neighbors = []
  end

  def to_s
    "Knight (y: #{position[0]}, x: #{position[1]})"
  end

  def show
    print " "
    8.times { |i| print " #{i+1}"}
    puts ""
    (1..8).each do |y|
      (1..8).each do |x|
        print "#{x == 1 ? y: ''}|#{position[0] == y && position[1] == x ? 'K': ' '}"
      end
      puts "|"
    end
  end
end

class KnightsGraph
  attr_reader :path, :root, :target

  def initialize(start_position, end_position)
    @root = KnightNode.new(start_position)
    @target = KnightNode.new(end_position)
    @path = []
    compute_tree
  end

  def compute_tree(root = @root, invalid_neighbors = [])
    # Allow cycles but work with simple graph
    # To deny cycles invalidad_neighbors should contain every neighbor of the previous compute nodes
    invalid_neighbors << root.position

    [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [-1, -2], [1, -2], [-2, -1]].each do |increment| 
      new_pos = [root.position, increment].transpose.map(&:sum) 
      if new_pos[0].between?(1, 8) && new_pos[1].between?(1, 8)
        root.neighbors << KnightNode.new(new_pos) unless invalid_neighbors.include? new_pos
      end
    end

    root.neighbors.each { |n| compute_tree(n, invalid_neighbors) }
  end

  def search_target(root = @root, curr_path = [], target = @target)
    curr_path << root.position

    if root.position == target.position
      if curr_path.size < @path.size || @path.size == 0
        @path = curr_path
      end
    elsif
      root.neighbors.each {|n| search_target(n, curr_path.map(&:clone))}
    end
  end

  def show_trace
    @path.each {|p| (KnightNode.new(p)).show }
  end
end

def knight_move(start_position, end_position)
  g = KnightsGraph.new(start_position, end_position)
  g.search_target
  g.show_trace
  puts "Knight moves from #{g.root.position} to #{g.target.position} in #{g.path.size} steps"
  puts "This is the path:"
  g.path.each { |s| puts "=> #{s}"}
end

def print_empty_board
  puts "Board distribution"
  puts "  1 2 3 4 5 6 7 8"
  8.times {|i| puts "#{i+1}" + "| "*8 + "|"}
end

def get_valid_input(text)
  input = nil
  loop do 
    print text 
    input = gets.chomp.split.map {|x| x.to_i}

    break unless input.nil? || input.select {|x| x.between?(1, 8)}.size != 2
  end
  input
end

print_empty_board

start_position = get_valid_input("> Start: ")
end_position = get_valid_input("> End  : ")

knight_move(start_position, end_position)
