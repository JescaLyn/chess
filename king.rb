require_relative "sliding_piece"

class King < SlidingPiece
  def to_s
    " #{"\u265a".encode('utf-8')} "
  end

  def move_dirs
    [:straight, :diagonal]
  end
end
