require_relative "display"
require_relative "board"

class Player
  attr_reader :color

  def initialize(board, color)
    @display = Display.new(board)
    @board = board
    @color = color
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end

  def make_move
    #TODO: raise "Not in valid moves!" unless @board[*start_pos].moves.include?(end_pos)
    start_pos = move
    end_pos = move
    @board.move(start_pos, end_pos)
    @display.render
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  dude = Player.new(board, :black)
  dude.make_move
end
