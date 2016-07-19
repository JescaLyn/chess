require_relative "sliding_piece"

class Rook < SlidingPiece
  def to_s
    " #{"\u265c".encode('utf-8')} "
  end

  def move_dirs
    [:straight]
  end
end
