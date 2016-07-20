require_relative "queen"
require_relative "king"
require_relative "knight"
require_relative "rook"
require_relative "bishop"
require_relative "pawn"
require_relative "game_error"

class Board
  attr_accessor :grid

  def initialize(fill_board = true)
    @grid = Array.new(8) { Array.new(8) }
    self.populate if fill_board
  end

  def populate
    (0..7).each do |idx|
      case idx
      when 1, 6
        @grid[idx].each_index do |squ_idx|
          self[idx, squ_idx] = Pawn.new(:black, self, [idx, squ_idx])
        end
      when 2, 3, 4, 5
        @grid[idx].each_index do |squ_idx|
          self[idx, squ_idx] = NullPiece.instance
        end
      when 0, 7
        populate_end_row(idx)
      end
    end
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

  def valid_move?(start_pos, end_pos)
    self[*start_pos].valid_moves.include?(end_pos)
  end

  def move(start_pos, end_pos)
    raise GameError, "Not a valid move." unless valid_move?(start_pos, end_pos)
    self[*start_pos], self[*end_pos] = self[*end_pos], self[*start_pos]
    self[*start_pos] = NullPiece.instance
    self[*end_pos].position = end_pos
  end

  def move!(start_pos, end_pos)
    self[*start_pos], self[*end_pos] = self[*end_pos], self[*start_pos]
    self[*start_pos] = NullPiece.instance
    self[*end_pos].position = end_pos
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def empty?(pos)
    self[*pos].is_a?(NullPiece)
  end

  def in_check?(color)
    king = all_pieces(color).find { |piece| piece.is_a?(King) }

    all_pieces(other_color(color)).each do |enemy_piece|
      return true if enemy_piece.moves.include?(king.position)
    end

    false
  end

  def checkmate?(color)
    return false unless self.in_check?(color)
    all_pieces(color).each do |piece|
      piece.moves.each do |move|
        new_board = self.dup
        new_board.move!(piece.position, move)
        return false unless new_board.in_check?(color)
      end
    end
    true
  end

  def other_color(color)
    color == :black ? :white : :black
  end

  def all_pieces(color = nil)
    return @grid.flatten if color == nil
    @grid.flatten.select { |piece| piece.color == color }
  end

  def dup
    new_board = Board.new(false)
    pieces = all_pieces.reject { |piece| piece.is_a?(NullPiece) }

    pieces.each do |piece|
      new_board[*piece.position] = piece.class.new(piece.color, new_board, piece.position)
    end

    new_board.grid.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        if new_board[row_idx, col_idx].nil?
          new_board[row_idx, col_idx] = NullPiece.instance
        end
      end
    end
    new_board
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  board.populate
  king = board[0, 4]
  board[1, 4] = NullPiece.instance
  board[3, 5] = Queen.new(:white, board, [3, 5])
  # p king.valid_moves
  board.move([0, 4], [1, 4])
  king.valid_moves
end
