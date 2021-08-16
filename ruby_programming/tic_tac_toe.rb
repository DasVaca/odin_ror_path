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
    won_main = [board[0][0], board[1][1]].include? board[2][2]
    won_alte = [board[0][2], board[1][1]].include? board[2][0]
    board[1][1] != EMPTY && (won_main || won_alte) ? board[1][1]: nil
  end

  def win_vertically
    winner_symb = nil

    for i in 0...3
      next if board[0][i] == EMPTY

      if [board[0][i], board[1][i]].include? board[2][i]
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
    row, col = *(pos == 0 ? pos: pos-1).divmod(3)
    begin
      board[row][col] = symb
    rescue NoMethodError
      puts "Out of bounds: Location (#{pos}) does not exists."
    end
  end

end

