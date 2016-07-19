require 'singleton'
require 'byebug'

class Piece
  attr_accessor :color, :position, :board

  def initialize(color, board, pos)
    @color = color
    @board = board
    @position = pos
  end

  def moves
  end

  def valid_moves
    debugger
    self.moves.reject do |move|
      new_board = @board.dup
      new_board.move(@position, move)
      new_board.in_check?(@color)
    end
  end

  def dup
    self.class.new(@color, @board, @position.dup)
  end
end

class NullPiece
  include Singleton

  def color
    nil
  end

  def to_s

    "   "
  end

  def moves
    []
  end
end
