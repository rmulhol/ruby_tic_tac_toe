class Runner
  attr_reader :user_interface, :board, :player_1, :player_2

  def initialize(ui, board, player_1, player_2)
    @user_interface = ui
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def run
    user_interface.describe_board_configuration(board)
    game_loop
  end

  def game_loop
    loop do
      single_game
      play_again = user_interface.play_again?
      board.clear_board
      break unless play_again
    end
  end

  def single_game
    cycle_moves_until_game_over
    user_interface.announce_outcome(board, player_1.move_signature, player_2.move_signature)
  end

  def cycle_moves_until_game_over
    user_interface.display_board(board)
    [player_1, player_2].cycle do |player|
      move = player.get_move(board)
      board.place_move(move, player.move_signature)
      user_interface.display_board(board)
      break if board.game_over?(player_1.move_signature, player_2.move_signature)
    end
  end
end