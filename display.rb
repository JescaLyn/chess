require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  include Cursorable
  attr_accessor :selected

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)

      if piece.color == :white
        color_options[:color] = :light_white
      else
        color_options[:color] = :black
      end

      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :yellow
    else
      bg = :light_black
    end
    { background: bg }
  end

  def render
    system("clear")
    if @selected
      puts "Where would you like to move that piece?"
    else
      puts "Pick a piece you want to move."
    end
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  display = Display.new(board)
  display.render
end
