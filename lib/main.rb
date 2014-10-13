require_relative 'runner'
require_relative 'board'
require_relative 'display'

my_game = Runner.new(Board.new, Display.new)
my_game.play_game
