require "pathname"
require Pathname(__dir__) + "lib" + "command_line_interface.rb"
require Pathname(__dir__) + "lib" + "input_output.rb"
require Pathname(__dir__) + "lib" + "messages.rb"
require Pathname(__dir__) + "lib" + "board_formatter.rb"
require Pathname(__dir__) + "lib" + "input_validator.rb"
require Pathname(__dir__) + "lib" + "configuration.rb"
require Pathname(__dir__) + "lib" + "runner.rb"

command_line_interface = CommandLineInterface.new(InputOutput.new, Messages.new, BoardFormatter.new, InputValidator.new)

user_selected_game_configuration = command_line_interface.get_game_configuration
game_runner = Configuration.new(command_line_interface, user_selected_game_configuration).configure_game
game_runner.run