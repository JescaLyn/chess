require_relative "queen"
require_relative "king"
require_relative "knight"
require_relative "rook"
require_relative "bishop"
require_relative "pawn"

class Board
  attr_accessor :grid

  def initialize()
    @grid = Array.new(8) { Array.new(8) }
    self.populate
  end

  def populate
    (0..7).each do |idx|
      case idx
      when 1, 6
        @grid[idx].each_index { |square_idx| self[idx, square_idx] = Pawn.new(:black, self, [idx, square_idx]) }
      when 2, 3, 4, 5
        @grid[idx].each_index { |square_idx| self[idx, square_idx] = NullPiece.instance }
      when 0, 7
        populate_end_row(idx)
      end
    end
    self[0, 3], self[0, 4] = self[0, 4], self[0, 3]
    self[0, 3].position = [0, 3]
    self[0, 4].position = [0, 4]
    set_white
  end

  def populate_end_row(idx)
    @grid[idx].each_index do |square_idx|
      case square_idx
      when 0, 7
        self[idx, square_idx] = Rook.new(:black, self, [idx, square_idx])
      when 1, 6
        self[idx, square_idx] = Knight.new(:black, self, [idx, square_idx])
      when 2, 5
        self[idx, square_idx] = Bishop.new(:black, self, [idx, square_idx])
      when 3
        self[idx, square_idx] = Queen.new(:black, self, [idx, square_idx])
      when 4
        self[idx, square_idx] = King.new(:black, self, [idx, square_idx])
      end
    end
  end

  def set_white
    (@grid[6] + @grid[7]).each do |el|
      el.color = :white
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, piece)
    @grid[row][col] = piece
  end

  def move(start_pos, end_pos)
    p self[*start_pos].moves
    raise "Not in valid moves!" unless self[*start_pos].moves.include?(end_pos)
    self[*start_pos], self[*end_pos] = self[*end_pos], self[*start_pos]
    self[*start_pos] = NullPiece.instance
    self[*end_pos].position = end_pos
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def empty?(pos)
    return true unless self.in_bounds?(pos)
    self[*pos].is_a?(NullPiece)
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  board.populate
  # board.grid.each do |row|
  #   row.each {|el| print "#{el.to_s}" }
  #   puts
  # end
  pawn = board[1, 5]
  p pawn.moves
  board[2,6] = Pawn.new(:white, board, [2, 6])
  board[2,4] = Pawn.new(:white, board, [2, 6])
  p pawn.moves
end
