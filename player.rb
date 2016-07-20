require_relative "display"
require_relative "board"
require_relative "game_error"

class Player
  attr_reader :color

  def initialize(board, color)
    @display = Display.new(board)
    @board = board
    @color = color
  end

  def prompt
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end

  def make_move
    start_pos = prompt
    @display.selected = true
    unless @board[*start_pos].color == @color
      raise GameError, "That is not a piece you own."
    end
    end_pos = prompt
    @display.selected = false
    @board.move(start_pos, end_pos)
  rescue GameError => e
    @display.selected = false
    puts e
    sleep(2)
    retry
  ensure
    @display.render
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  dude = Player.new(board, :black)
  dude.make_move
end
