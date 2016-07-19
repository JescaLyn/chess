require_relative "sliding_piece"
require_relative "piece"

class Bishop < Piece
  include SlidingPiece
  
  def to_s
    " #{"\u265d".encode('utf-8')} "
  end

  def move_dirs
    [:diagonal]
  end
end
