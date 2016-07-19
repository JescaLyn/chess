require_relative "sliding_piece"

class Bishop < SlidingPiece
  def to_s
    " #{"\u265d".encode('utf-8')} "
  end

  def move_dirs
    [:diagonal]
  end
end
