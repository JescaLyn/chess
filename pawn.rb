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
    forward_dir + side_attacks
  end

  def forward_dir
    moves = []
    x, y = @position
    up_move = [x + 1, y]
    down_move = [x - 1, y]

    if @color == :black && @board.in_bounds?(up_move) &&
      @board.empty?(up_move)
      moves << [x + 1, y]
      moves << [x + 2, y] if at_start_row?
    elsif @color == :white && @board.in_bounds?(down_move) &&
      @board.empty?(down_move)
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

    if @position == [6, 7]
      p attacks
      p attacks.select { |move| is_enemy?(move) }
      sleep(2)
    end

    attacks.select { |move| is_enemy?(move) }
  end

  def at_start_row?
    @position == @start_pos
  end

  def is_enemy?(pos)
    return false unless @board.in_bounds?(pos)
    (@board[*pos].color == @color || @board.empty?(pos)) ? false : true
  end
end
