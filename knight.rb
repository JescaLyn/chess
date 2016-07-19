require_relative "piece"

class Knight < Piece
  DELTAS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ]

  def to_s
    " #{"\u265e".encode('utf-8')} "
  end

  def moves
    poss_moves.select do |pos|
      @board.in_bounds?(pos) && @board[*pos].color != @color
    end
  end

  def poss_moves
    moves = []
    x, y = @position

    DELTAS.each do |delta|
      new_pos = [x + delta[0], y + delta[1]]
      moves << new_pos
    end
    moves
  end
end
