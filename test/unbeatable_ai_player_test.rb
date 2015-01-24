require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "unbeatable_ai_player.rb"
require Pathname(__dir__).parent + "lib" + "board.rb"

class UnbeatableAiPlayerTest < Minitest::Test

  def setup
    @unbeatable_ai_player_as_X = UnbeatableAiPlayer.new("X")
    @unbeatable_ai_player_as_O = UnbeatableAiPlayer.new("O")
  end

  def test_get_move
    board_with_potential_X_win = Board.new(3)
    board_with_potential_X_win.place_move(1, "X")
    board_with_potential_X_win.place_move(4, "O")
    board_with_potential_X_win.place_move(2, "X")
    
    assert_equal 3, @unbeatable_ai_player_as_X.get_move(board_with_potential_X_win), "get_move should claim win if available"
    assert_equal 3, @unbeatable_ai_player_as_O.get_move(board_with_potential_X_win), "get_move should block loss if loss possible on next move and no winning option"

    board_with_potential_win_for_both_X_and_O = board_with_potential_X_win
    board_with_potential_win_for_both_X_and_O.place_move(5, "O")

    assert_equal 3, @unbeatable_ai_player_as_X.get_move(board_with_potential_win_for_both_X_and_O), "get_move should claim win if separate win and loss blocking moves are available"

    board_with_possible_fork = Board.new(3)
    board_with_possible_fork.place_move(1, "X")
    board_with_possible_fork.place_move(5, "O")
    board_with_possible_fork.place_move(9, "X")

    fork_blocking_moves = [2, 4, 6, 8]

    assert_includes fork_blocking_moves, @unbeatable_ai_player_as_O.get_move(board_with_possible_fork), "get_move should block fork if no win or loss blocking move available"
  end

  def test_minimax
    board_with_X_win = Board.new(3)
    board_with_X_win.place_move(1, "X")
    board_with_X_win.place_move(2, "X")
    board_with_X_win.place_move(3, "X")

    assert_equal 10, @unbeatable_ai_player_as_X.minimax(board_with_X_win, true, "O", 1), "minimax should return 10 if board state guarantees player win"
    assert_equal -10, @unbeatable_ai_player_as_O.minimax(board_with_X_win, true, "X", 1), "minimax should return -10 if board state guarantees player loss"
  end

  def test_score_board
    board_with_X_win = Board.new(3)
    board_with_X_win.place_move(1, "X")
    board_with_X_win.place_move(2, "X")
    board_with_X_win.place_move(3, "X")

    board_without_win = Board.new(3)

    assert_equal 10, @unbeatable_ai_player_as_X.score_board(board_with_X_win, "O"), "score_board should return 10 if player wins"
    assert_equal -10, @unbeatable_ai_player_as_O.score_board(board_with_X_win, "X"), "score_board should return -10 if player loses"

    assert_equal 0, @unbeatable_ai_player_as_X.score_board(board_without_win, "X"), "score_board should return 0 if neither player has won"
  end

  def test_get_opponent
    board_with_X_and_O = Board.new(3)
    board_with_X_and_O.place_move(1, "X")
    board_with_X_and_O.place_move(2, "O")

    board_without_moves = Board.new(3)

    board_with_X = Board.new(3)
    board_with_X.place_move(1, "X")

    assert_equal "O", @unbeatable_ai_player_as_X.get_opponent(board_with_X_and_O), "get_opponent should return 'O' if ai player is 'X' and board contains an 'O'"
    assert_equal "X", @unbeatable_ai_player_as_O.get_opponent(board_with_X_and_O), "get_opponent should return 'X' if ai player is 'O' and board contains an 'X'"
    assert_equal :no_opponent_move, @unbeatable_ai_player_as_X.get_opponent(board_without_moves), "get_opponent should return :no_opponent_move if board does not contain a move"
    assert_equal :no_opponent_move, @unbeatable_ai_player_as_X.get_opponent(board_with_X), "get_opponent should return :no_opponent_move if board doe not contain move other than ai player"
  end

end