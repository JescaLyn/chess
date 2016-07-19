require_relative "piece"

class Pawn < Piece
  def initialize(color, board, start_pos)
    @start_pos = start_pos
    super
  end

  def to_s
    " #{"\u265f".encode('utf-8')} "
  end

  def moves
    (forward_dir + side_attacks).select { |move| @board.in_bounds?(move) }
  end

  def forward_dir
    moves = []
    x, y = @position

    if @color == :black && @board.empty?([x + 1, y])
      moves << [x + 1, y]
      moves << [x + 2, y] if at_start_row?
    elsif @color == :white && @board.empty?([x - 1, y])
      moves << [x - 1, y]
      moves << [x - 2, y] if at_start_row?
    end

    moves.select { |move_pos| @board.empty?(move_pos) }
  end

  def side_attacks
    attacks = []
    x, y = @position

    if @color == :black
      attacks << [x + 1, y + 1]
      attacks << [x + 1, y - 1]
    else
      attacks << [x - 1, y + 1]
      attacks << [x + 1, y - 1]
    end

    attacks.select { |move| is_enemy?(move) }
  end

  def at_start_row?
    @position == @start_pos
  end

  def is_enemy?(pos)
    (@board[*pos].color == @color || @board.empty?(pos)) ? false : true
  end
end
