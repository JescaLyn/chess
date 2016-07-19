require_relative "player"
require_relative "board"
require_relative "display"

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new(@board, :white)
    @player2 = Player.new(@board, :black)
    @current_player = @player1
  end

  def switch_player!
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

  def play
    won = false

    until won
      @current_player.make_move
    end

    puts "Somebody won!"
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end
