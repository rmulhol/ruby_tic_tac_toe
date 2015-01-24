require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "configuration.rb"
require Pathname(__dir__).parent + "lib" + "command_line_interface.rb"
require Pathname(__dir__).parent + "lib" + "input_output.rb"
require Pathname(__dir__).parent + "lib" + "mock_io_stream.rb"
require Pathname(__dir__).parent + "lib" + "messages.rb"
require Pathname(__dir__).parent + "lib" + "board_formatter.rb"
require Pathname(__dir__).parent + "lib" + "input_validator.rb"
require Pathname(__dir__).parent + "lib" + "runner.rb"

class ConfigurationTest < Minitest::Test

  def setup
    @config = generate_configuration_with_settings
  end

  def generate_configuration_with_settings(settings = {})
    input_stream = MockIoStream.new
    output_stream = MockIoStream.new
    io = InputOutput.new(input_stream, output_stream)
    messages = Messages.new
    board_formatter = BoardFormatter.new
    input_validator = InputValidator.new
    cli = CommandLineInterface.new(io, messages, board_formatter, input_validator)
    Configuration.new(cli, settings)
  end

  def test_configure_game
    hvh_game_settings = { board_side_length: 3, 
                              player_1: {player_type: :human_player, move_signature: "X"}, 
                              player_2: {player_type: :human_player, move_signature: "O"} } 
    hvc_game_settings = { board_side_length: 4, 
                              player_1: {player_type: :human_player, move_signature: "X"}, 
                              player_2: {player_type: :beatable_ai_player, move_signature: "O"} } 
    cvc_game_settings = { board_side_length: 5, 
                              player_1: {player_type: :beatable_ai_player, move_signature: "X"}, 
                              player_2: {player_type: :unbeatable_ai_player, move_signature: "O"} } 

    hvh_game = generate_configuration_with_settings(hvh_game_settings)
    hvc_game = generate_configuration_with_settings(hvc_game_settings)
    cvc_game = generate_configuration_with_settings(cvc_game_settings)

    assert_instance_of Runner, hvh_game.configure_game, "configure_game should return a runner"
    assert_instance_of Runner, hvc_game.configure_game, "configure_game should return a runner"
    assert_instance_of Runner, cvc_game.configure_game, "configure_game should return a runner"

    assert_instance_of HumanPlayer, hvh_game.configure_game.player_1, "configure_game should return a runner with a human player as player 1 in a HvH game"
    assert_instance_of HumanPlayer, hvh_game.configure_game.player_2, "configure_game should return a runner with a human player as player 2 in a HvH game"

    assert_instance_of HumanPlayer, hvc_game.configure_game.player_1, "configure_game should return a runner with a human player as player 1 in a HvC game"
    assert_instance_of BeatableAiPlayer, hvc_game.configure_game.player_2, "configure_game should return a runner with an ai player as player 2 in a HvC game"

    assert_instance_of BeatableAiPlayer, cvc_game.configure_game.player_1, "configure_game should return a runner with an ai player as player 1 in a CvC game"
    assert_instance_of UnbeatableAiPlayer, cvc_game.configure_game.player_2, "configure_game should return a runner with an ai player as player 2 in a CvC game"

    assert_equal 3, hvh_game.configure_game.board.side_length, "configure_game should return a runner with a 3x3 board if :board_side_length is 3"
    assert_equal 4, hvc_game.configure_game.board.side_length, "configure_game should return a runner with a 4x4 board if :board_side_length is 4"
    assert_equal 5, cvc_game.configure_game.board.side_length, "configure_game should return a runner with a 5x5 board if :board_side_length is 5"
  end

  def test_player
    human_player_settings =  { player_type: :human_player, move_signature: "X" }
    beatable_ai_player_settings = { player_type: :beatable_ai_player, move_signature: "X" }
    unbeatable_ai_player_settings = { player_type: :unbeatable_ai_player, move_signature: "X" }

    assert_instance_of HumanPlayer, @config.player(human_player_settings), "player should return a human player if :player_type is :human_player"
    assert_instance_of BeatableAiPlayer, @config.player(beatable_ai_player_settings), "player should return a beatable ai player if :player_type is :beatable_ai_player"
    assert_instance_of UnbeatableAiPlayer, @config.player(unbeatable_ai_player_settings), "player should return an unbeatable ai player if :player_type is :unbeatable_ai_player"
  end

  def test_human_player
    assert_instance_of HumanPlayer, @config.human_player("X"), "human_player should return a new instance of HumanPlayer"
  end

  def test_beatable_ai_player
    assert_instance_of BeatableAiPlayer, @config.beatable_ai_player("X"), "beatable_ai_player should return a new instance of BeatableAiPlayer"
  end

  def test_unbeatable_ai_player
    assert_instance_of UnbeatableAiPlayer, @config.unbeatable_ai_player("X"), "unbeatable_ai_player should return a new instance of UnbeatableAiPlayer"
  end
end