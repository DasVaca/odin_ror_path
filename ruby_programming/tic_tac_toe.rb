class Board
  
  EMPTY = ' '
  VSEP = '|'

  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3, EMPTY) }
  end

  def empty?
    board.flatten.select { |c| c != EMPTY}.count == 0
  end

  def win_horizontal
    winner_symb = nil

    for i in 0...3 
      next if board[i][0] == EMPTY

      if board[i].all? { |cell| cell == board[i][0]}
        winner_symb = board[i][0]
        break
      end
    end

    winner_symb
  end

  def win_diagonally
    won_main = [board[0][0], board[1][1]].all? { |c| c ==  board[2][2] }
    won_alte = [board[0][2], board[1][1]].all? { |c| c ==  board[2][0] }
    (board[1][1] != EMPTY && (won_main || won_alte)) ? board[1][1]: nil
  end

  def win_vertically
    winner_symb = nil

    for i in 0...3
      next if board[0][i] == EMPTY

      if [board[0][i], board[1][i]].all? { |c| c == board[2][i] }
        winner_symb = board[0][i]
        break
      end
    end

    winner_symb
  end

  def winner?
    win_horizontal || win_diagonally || win_vertically 
  end
  
  def show
    board.each_with_index do |r, i|
      puts r.each_with_index.map { |c, j| c == EMPTY ? i*3 + j + 1: c}.join(VSEP)
    end
  end

  def mark_cell(pos, symb)
    raise ArgumentError.new("Out of bounds: Location (#{pos}) does not exists.") unless pos.between?(1, 9) 

    row, col = (pos - 1).divmod(3)
    board[row][col] = symb
  end

end


class Game

  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = []
  end

  def play
    2.times do |i|
      puts "Register player #{i+1}"
      register_player
    end
    
    turn = 0

    loop do
      break if board.winner?

      curr_player = players[turn % 2]
      
      puts "#{curr_player[:name]} is playing with symbol #{curr_player[:symbol]}."
      board.show

      begin
        print "Position to mark: "
        position = gets.chomp.to_i
        board.mark_cell(position, curr_player[:symbol])
      rescue ArgumentError => e
        puts e
        puts "Please enter a valid position."
        retry
      end

      turn += 1
    end

    puts "Game ended."
  end

  def get_player
    print "Name: "
    name = gets.chomp
    
    print "Symbol: "
    symbol = gets.chomp

    {name: name, symbol: symbol}
  end

  def symbol_taken? (symbol)
    return false if players.size == 0

    players[0][:symbol] == symbol
  end

  def register_player
    new_player = nil
    loop do 
      new_player = get_player

      break if not symbol_taken? new_player[:symbol]

      puts "Symbol already taken. Please try again with a different symbol."
    end
    players << new_player 
  end
end

(Game.new).play
