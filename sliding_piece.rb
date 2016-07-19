require_relative "piece"

class SlidingPiece < Piece
  DIAG_DELTA = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]

  STR_DELTA = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ]

  def moves
    poss_moves.select do |pos|
      @board.in_bounds?(pos) && @board[*pos].color != @color
    end
  end

  def poss_moves
    moves = []
    x, y = @position
    deltas = []

    deltas << STR_DELTA if self.move_dirs.include?(:straight)
    deltas << DIAG_DELTA if self.move_dirs.include?(:diagonal)

    deltas.each do |delta|
      delta.each do |change|
        index = 1
        while index <= 7
          new_pos = [x + (change[0] * index), y + (change[1] * index)]
          moves << new_pos
          break if self.is_a?(King)
          break unless @board.empty?(new_pos)
          index += 1
        end
      end
    end

    moves
  end
end
