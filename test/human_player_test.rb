require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "human_player.rb"
require Pathname(__dir__).parent + "lib" + "command_line_interface.rb"
require Pathname(__dir__).parent + "lib" + "input_output.rb"
require Pathname(__dir__).parent + "lib" + "mock_io_stream.rb"
require Pathname(__dir__).parent + "lib" + "messages.rb"
require Pathname(__dir__).parent + "lib" + "board_formatter.rb"
require Pathname(__dir__).parent + "lib" + "input_validator.rb"

class HumanPlayerTest < Minitest::Test

  def generate_human_player_with_input(input)
    input_stream = MockIoStream.new(input)
    output_stream = MockIoStream.new
    io = InputOutput.new(input_stream, output_stream)
    messages = Messages.new
    board_formatter = BoardFormatter.new
    input_validator = InputValidator.new
    cli = CommandLineInterface.new(io, messages, board_formatter, input_validator)
    HumanPlayer.new("X", cli)
  end

  def test_get_move
    @human_player_with_valid_input = generate_human_player_with_input(["1"])
    @human_player_with_invalid_input = generate_human_player_with_input(["-1", "100", "2"])
    @human_player_with_input_for_claimed_spaces = generate_human_player_with_input(["1", "2", "3"])
    
    @empty_board = Board.new(3)
    
    @board_with_spaces_claimed = Board.new(3)
    @board_with_spaces_claimed.place_move(1, "X")
    @board_with_spaces_claimed.place_move(2, "O")

    assert_equal 1, @human_player_with_valid_input.get_move(@empty_board)
    assert_equal 2, @human_player_with_invalid_input.get_move(@empty_board)
    assert_equal 3, @human_player_with_input_for_claimed_spaces.get_move(@board_with_spaces_claimed)
  end
end