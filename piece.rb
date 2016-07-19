require 'singleton'

class Piece
  attr_accessor :color, :position

  def initialize(color, board, pos)
    @color = color
    @board = board
    @position = pos
  end

  def moves
  end
end

class NullPiece
  include Singleton
  attr_reader :color

  def to_s

    "   "
  end

  def moves
    []
  end
end
