require "pathname"
require Pathname(__dir__) + "lib" + "command_line_interface.rb"
require Pathname(__dir__) + "lib" + "input_output.rb"
require Pathname(__dir__) + "lib" + "messages.rb"
require Pathname(__dir__) + "lib" + "board_formatter.rb"
require Pathname(__dir__) + "lib" + "input_validator.rb"
require Pathname(__dir__) + "lib" + "configuration.rb"
require Pathname(__dir__) + "lib" + "runner.rb"

command_line_interface = CommandLineInterface.new(InputOutput.new, Messages.new, BoardFormatter.new, InputValidator.new)

configurer = Configuration.new(command_line_interface)
game_configuration = configurer.configure_game

game_runner = Runner.new(game_configuration)
game_runner.run