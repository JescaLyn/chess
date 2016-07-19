require_relative "sliding_piece"
require_relative "piece"

class Rook < Piece
  include SlidingPiece

  def to_s
    " #{"\u265c".encode('utf-8')} "
  end

  def move_dirs
    [:straight]
  end
end
