require_relative "sliding_piece"
require_relative "piece"

class Queen < Piece
  include SlidingPiece
  
  def to_s
    " #{"\u265b".encode('utf-8')} "
  end

  def move_dirs
    [:straight, :diagonal]
  end
end
