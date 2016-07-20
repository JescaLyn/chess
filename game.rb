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
    until @board.checkmate?(@current_player.color)
      display_player
      @current_player.make_move
      switch_player!
    end

    switch_player!
    puts "Checkmate. #{@current_player.color.to_s.capitalize} won!"
  end

  def display_player
    system("clear")
    puts "#{@current_player.color.to_s.capitalize}'s turn."
    sleep(1)
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.play
end
