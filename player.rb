require_relative "display"
require_relative "board"

class Player
  def initialize(board, color)
    @display = Display.new(board)
    @board = board
    @color == color
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
    start_pos = move
    end_pos = move
    @board.move(start_pos, end_pos)
    @display.render
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  dude = Player.new(board)
  dude.make_move
end
