require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "command_line_interface.rb"
require Pathname(__dir__).parent + "lib" + "input_output.rb"
require Pathname(__dir__).parent + "lib" + "mock_io_stream.rb"
require Pathname(__dir__).parent + "lib" + "messages.rb"
require Pathname(__dir__).parent + "lib" + "board_formatter.rb"
require Pathname(__dir__).parent + "lib" + "input_validator.rb"
require Pathname(__dir__).parent + "lib" + "board.rb"

class CommandLineInterfaceTest < Minitest::Test

  def setup
    @cli = generate_cli_with_input
  end

  def generate_cli_with_input(input = ["gets was called"])
    input_stream = MockIoStream.new(input)
    output_stream = MockIoStream.new
    
    io = InputOutput.new(input_stream, output_stream)
    messages = Messages.new
    board_formatter = BoardFormatter.new
    input_validator = InputValidator.new
    
    CommandLineInterface.new(io, messages, board_formatter, input_validator)
  end

  def test_get_game_configuration
    cli_with_negative_input = generate_cli_with_input(["no"])
    cli_with_affirmative_input = generate_cli_with_input(["yes", "4", "beatable", "O", "human", "X"])

    default_game_configuration = { board_side_length: 3, 
        player_1: { player_type: :human_player, move_signature: "X" }, 
        player_2: { player_type: :beatable_ai_player, move_signature: "O" } }

    custom_game_configuration = { board_side_length: 4,
        player_1: { player_type: :beatable_ai_player, move_signature: "O" },
        player_2: { player_type: :human_player, move_signature: "X" } }

    assert_equal default_game_configuration, cli_with_negative_input.get_game_configuration, "get_game_configuration should return default game if user opts not to create a custom game"
    assert_equal custom_game_configuration, cli_with_affirmative_input.get_game_configuration, "get_game_configuration should return custom game settings in accordance with user input"
  end

  def test_get_custom_game_configuration
    cli_with_hvh_input = generate_cli_with_input(["3", "human", "X", "human", "O"])
    cli_with_cvc_input = generate_cli_with_input(["4", "beatable", "O", "unbeatable", "X"])
    
    hvh_game_settings = { board_side_length: 3, 
      player_1: { player_type: :human_player, move_signature: "X" }, 
      player_2: { player_type: :human_player, move_signature: "O" } }

    cvc_game_settings = { board_side_length: 4, 
      player_1: { player_type: :beatable_ai_player, move_signature: "O" }, 
      player_2: { player_type: :unbeatable_ai_player, move_signature: "X" } }

    assert_equal hvh_game_settings, cli_with_hvh_input.get_custom_game_configuration, "get_custom_game_configuration should return HvH game if requested by the user"
    assert_equal cvc_game_settings, cli_with_cvc_input.get_custom_game_configuration, "get_custom_game_configuration should return CvC game if requested by the user"
  end

  def test_get_player_info
    cli_with_human_input = generate_cli_with_input(["human", "X"])
    cli_with_ai_input = generate_cli_with_input(["beatable", "X"])

    human_player_settings = { player_type: :human_player, move_signature: "X" }
    ai_player_settings = { player_type: :beatable_ai_player, move_signature: "X" }

    assert_equal human_player_settings, cli_with_human_input.get_player_info(1), "get_player_info should return human player settings if user selects 'human'"
    assert_equal ai_player_settings, cli_with_ai_input.get_player_info(1), "get_player_info should return ai player settings if user selects 'ai'"
  end


  def test_welcome_user
    assert_equal @cli.welcome_user, "puts was called", "welcome_user should call IO#puts to welcome the user"
  end

  def test_modify_game_configuration
    cli_with_affirmative_input = generate_cli_with_input(["yes"])
    cli_with_negative_input = generate_cli_with_input(["no"])

    assert cli_with_affirmative_input.modify_game_configuration?, "modify_game_configuration? should return true when input is 'yes'"
    assert !cli_with_negative_input.modify_game_configuration?, "modify_game_configuration? should return false when input is 'no'"
  end

  def test_describe_board_configuration
    test_board = Board.new(3)

    assert_equal "puts was called", @cli.describe_board_configuration(test_board), "describe_board_configuration should call IO#puts to describe the board"
  end

  def test_get_board_side_length
    cli_with_valid_input = generate_cli_with_input(["3"])
    cli_with_invalid_input = generate_cli_with_input(["2", "10", "4"])

    assert_equal 3, cli_with_valid_input.get_board_side_length, "get_board_side_length should return the valid input entered by the user as an integer"
    assert_equal 4, cli_with_invalid_input.get_board_side_length, "get_board_side_length should reject invalid input until valid input is entered"
  end

  def test_get_player_type
    cli_with_valid_input = generate_cli_with_input(["human"])
    cli_with_invalid_input = generate_cli_with_input(["invalid input", "beatable"])

    assert_equal :human_player, cli_with_valid_input.get_player_type(1), "get_player_type should return the symbol corresponding to the user's valid input"
    assert_equal :beatable_ai_player, cli_with_invalid_input.get_player_type(2), "get_player_type should reject invalid input until valid input is entered"
  
    # test for unbeatable player

  end

  def test_return_player_type
    assert_equal :human_player, @cli.return_player_type("human"), "return_player_type should return the symbol corresponding to a human player if input is 'human'"
    assert_equal :beatable_ai_player, @cli.return_player_type("beatable"), "return_player_type should return the symbol corresponding to a beatable ai player if the input is 'beatable'"
  
    # test for unbeatable player

  end

  def test_get_player_move_signature
    cli_with_valid_input = generate_cli_with_input(["X"])
    cli_with_multi_character_input = generate_cli_with_input(["XX", "OO", "O"])
    cli_with_taken_move_signatures = generate_cli_with_input(["X", "O"])

    assert_equal "X", cli_with_valid_input.get_player_move_signature(1, []), "get_player_move_signature should return the valid move signature entered by the user"
    assert_equal "O", cli_with_multi_character_input.get_player_move_signature(1, []), "get_player_move_signature should reject multi-character input until a single-character move signature is selected"
    assert_equal "O", cli_with_taken_move_signatures.get_player_move_signature(1, ["X"]), "get_player_move_signature should reject taken move signatures until a unique move signature is entered"
  end

  def test_request_move
    assert_equal "puts was called", @cli.request_move, "request_move should call IO#puts to instruct the user to select a move"
  end

  def test_announce_invalid_move
    assert_equal "puts was called", @cli.announce_invalid_move, "announce_invalid_move should call IO#puts to notify user that move selected is not valid"
  end

  def test_display_board
    test_board = Board.new(3)

    assert_equal "puts was called", @cli.display_board(test_board), "display_board should call IO#puts to display the current state of the board"
  end

  def test_announce_outcome
    test_board = Board.new(3)

    assert_equal "puts was called", @cli.announce_outcome(test_board, "X", "O"), "announce_outcome should call IO#puts to announce the outcome of the game"
  end

  def test_play_again
    cli_with_affirmative_input = generate_cli_with_input(["yes"])
    cli_with_negative_input = generate_cli_with_input(["no"])

    assert cli_with_affirmative_input.play_again?, "play_again? should return true if user enters 'yes'"
    assert !cli_with_negative_input.play_again?, "play_again? should return false if user enters 'no'"
  end

  def test_get_validated_input
    prompt = lambda { "prompt" }
    condition = lambda { |input| input == "hello" }

    cli_with_valid_input = generate_cli_with_input(["hello"])
    cli_with_invalid_input = generate_cli_with_input(["invalid input", "hello"])

    assert_equal "hello", cli_with_valid_input.get_validated_input(prompt, condition), "get_validated_input should return valid input entered by the user"
    assert_equal "hello", cli_with_invalid_input.get_validated_input(prompt, condition), "get_validated_input should reject invalid input until valid input is entered"
  end
end