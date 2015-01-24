require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "messages.rb"
require Pathname(__dir__).parent + "lib" + "board.rb"

class MessagesTest < Minitest::Test

  def setup
    @messages = Messages.new
    @crlf = "\n"
  end

  def test_welcome_user
    assert_includes @messages.welcome_user, "Welcome to Tic Tac Toe", "welcome_user should introduce the game"
  end

  def test_offer_to_modify_game_configuration
    assert_includes @messages.offer_to_modify_game_configuration, "like to modify", "offer_to_modify_game_configuration should offer user chance to modify game configuration"
  end

  def test_request_board_side_length
    assert_includes @messages.request_board_side_length, "What size board", "request_board_side_length should query what size board user would like to play on"
  end

  def test_request_player_type
    assert_includes @messages.request_player_type(1), "What type", "request_player_type should query user for player type"
    assert_includes @messages.request_player_type(1), "1", "request_player_type should include the number of the player it's getting a type for"
    assert_includes @messages.request_player_type(1), "Human", "request_player_type should offer human player as an available type"
    assert_includes @messages.request_player_type(1), "Beatable", "request_player_type should offer Beatable AI player as an available type"
    assert_includes @messages.request_player_type(1), "Unbeatable", "request_player_type should offer Unbeatable AI player as an available type"
  end

  def test_request_player_move_signature
    assert_includes @messages.request_player_move_signature(1), "move signature", "request_player_move_signature should query user for player move signature"
    assert_includes @messages.request_player_move_signature(1), "1", "request_player_move_signature should include the number of the player it's getting a move signature for"
  end

  def test_introduce_board
    board_3x3 = Board.new(3)
    board_4x4 = Board.new(4)

    assert_includes @messages.introduce_board(board_3x3), "indexed like so", "introduce_board should introduce board display with indexes"
    assert_includes @messages.introduce_board(board_3x3), "3x3", "introduce_board should include '3x3' for a 3x3 board"
    assert_includes @messages.introduce_board(board_4x4), "4x4", "introduce_board should include '4x4' for a 4x4 board"
  end

  def test_request_move
    assert_includes @messages.request_move, "Which space", "request_move should ask user for a space to claim"
  end

  def test_announce_invalid_move
    assert_includes @messages.announce_invalid_move, "not a valid move", "announce_invalid_move should announce that move is not valid"
  end

  def test_player_1_wins
    assert_includes @messages.player_1_wins, "Player 1 wins!", "player_1_wins should announce a win for player 1"
  end

  def test_player_2_wins
    assert_includes @messages.player_2_wins, "Player 2 wins!", "player_2_wins should announce a win for player 2"
  end

  def test_tie_game
    assert_includes @messages.tie_game, "Tie game!", "tie_game should announce a tie game"
  end

  def test_offer_to_play_again
    assert_includes @messages.offer_to_play_again, "play again?", "offer_to_play_again should offer the user a chance to play again"
  end

  def test_invalid_input
    assert_includes @messages.invalid_input, "don't understand", "invalid_input should notify the user that their input is not recognized as valid"
  end
end