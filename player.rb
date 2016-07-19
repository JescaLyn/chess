require_relative "display"
require_relative "board"

class Player
  def initialize(board)
    @display = Display.new(board)
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  dude = Player.new(board)
  dude.move
end
