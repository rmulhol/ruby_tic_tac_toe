require "pathname"

require Pathname(__dir__) + "lib" + "command_line_interface.rb"
require Pathname(__dir__) + "lib" + "input_output.rb"
require Pathname(__dir__) + "lib" + "messages.rb"
require Pathname(__dir__) + "lib" + "board_formatter.rb"
require Pathname(__dir__) + "lib" + "input_validator.rb"

require "bundler/setup"
require "negamax_ttt"

command_line_interface = CommandLineInterface.new(InputOutput.new, Messages.new, BoardFormatter.new, InputValidator.new)
game_runner = Configuration.new(command_line_interface).configure_game
game_runner.run