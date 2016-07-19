require_relative "piece"

class Pawn < Piece
  def to_s
    " #{"\u265f".encode('utf-8')} "
  end
end
