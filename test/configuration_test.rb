require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "configuration.rb"
require Pathname(__dir__).parent + "lib" + "command_line_interface.rb"
require Pathname(__dir__).parent + "lib" + "input_output.rb"
require Pathname(__dir__).parent + "lib" + "mock_io_stream.rb"
require Pathname(__dir__).parent + "lib" + "messages.rb"
require Pathname(__dir__).parent + "lib" + "board_formatter.rb"
require Pathname(__dir__).parent + "lib" + "input_validator.rb"

class ConfigurationTest < Minitest::Test

  def setup
    @config = generate_configuration_with_input
  end

  def generate_configuration_with_input(input = ["gets was called"])
    input_stream = MockIoStream.new(input)
    output_stream = MockIoStream.new
    io = InputOutput.new(input_stream, output_stream)
    messages = Messages.new
    board_formatter = BoardFormatter.new
    input_validator = InputValidator.new
    cli = CommandLineInterface.new(io, messages, board_formatter, input_validator)
    Configuration.new(cli)
  end

  def test_configure_game
    @default_game = generate_configuration_with_input(["no"])
    @config_with_custom_configuration = generate_configuration_with_input(["yes", "6", "human", "X", "ai", "O"])

    default_game_configuration = @default_game.configure_game
    custom_game_configuration = @config_with_custom_configuration.configure_game
    
    assert_kind_of CommandLineInterface, default_game_configuration.fetch(:user_interface), "configure_game should return hash containing game UI"
    
    assert_kind_of Board, default_game_configuration.fetch(:board), "configure_game should return hash containing a board"
    assert_equal 3, default_game_configuration.fetch(:board).side_length, "board should be set to side length 3 by default"
    
    assert_kind_of HumanPlayer, default_game_configuration.fetch(:player_1), "configure_game should return hash containing player_2 as human player by default"
    assert_equal "X", default_game_configuration.fetch(:player_1).move_signature, "player_1 move signature should be set to 'X' by default"
    
    assert_kind_of DumbAiPlayer, default_game_configuration.fetch(:player_2), "configure_game should return hash containing player_1 as dumb ai player by default"
    assert_equal "O", default_game_configuration.fetch(:player_2).move_signature, "player_2 move signature should be set to 'O' by default"

    assert_kind_of CommandLineInterface, custom_game_configuration.fetch(:user_interface), "configure_game should return hash containing game UI"
    
    assert_kind_of Board, custom_game_configuration.fetch(:board), "configure_game should return hash containing a board"
    assert_equal 6, custom_game_configuration.fetch(:board).side_length, "board should correspond to input by user"
    
    assert_kind_of HumanPlayer, custom_game_configuration.fetch(:player_1), "configure_game should return hash containing player_2 as described by the user"
    assert_equal "X", custom_game_configuration.fetch(:player_1).move_signature, "player_1 move signature should correspond to input by user"
    
    assert_kind_of DumbAiPlayer, custom_game_configuration.fetch(:player_2), "configure_game should return hash containing player_1 as described by the user"
    assert_equal "O", custom_game_configuration.fetch(:player_2).move_signature, "player_2 move signature should correspond to input by user"
  end

  def test_get_custom_configuration
    @config_with_custom_configuration = generate_configuration_with_input(["5", "ai", "X", "human", "O"])
    custom_game_configuration = @config_with_custom_configuration.get_custom_configuration

    assert_kind_of CommandLineInterface, custom_game_configuration.fetch(:user_interface), "get_custom_configuration should return hash containing game UI"
    
    assert_kind_of Board, custom_game_configuration.fetch(:board), "get_custom_configuration should return hash containing a board"
    assert_equal 5, custom_game_configuration.fetch(:board).side_length, "board should correspond to description input by the user"
    
    assert_kind_of DumbAiPlayer, custom_game_configuration.fetch(:player_1), "get_custom_configuration should return hash containing player_1 as described by the user"
    assert_equal "X", custom_game_configuration.fetch(:player_1).move_signature, "player_1 move signature should correspond to input by user"
    
    assert_kind_of HumanPlayer, custom_game_configuration.fetch(:player_2), "get_custom_configuration should return hash containing player_2 as described by the user"
    assert_equal "O", custom_game_configuration.fetch(:player_2).move_signature, "player_2 move signature should correspond to input by user"
  end

  def test_get_player_info
    @config_for_human_player = generate_configuration_with_input(["human", "X"])
    @config_for_ai_player = generate_configuration_with_input(["ai", "X"])

    assert_kind_of HumanPlayer, @config_for_human_player.get_player_info(1), "get_player_info should return a new instance of HumanPlayer if selected by user"
    assert_kind_of DumbAiPlayer, @config_for_ai_player.get_player_info(1), "get_player_info should return a new instance of DumbAiPlayer if selected by user"
  end

  def test_human_player
    assert_kind_of HumanPlayer, @config.human_player("X"), "human_player should return a new instance of HumanPlayer"
  end

  def test_dumb_ai_player
    assert_kind_of DumbAiPlayer, @config.dumb_ai_player("X"), "dumb_ai_player should return a new instance of DumbAiPlayer"
  end
end