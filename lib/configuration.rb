require "pathname"
require Pathname(__dir__) + "board.rb"
require Pathname(__dir__) + "human_player.rb"
require Pathname(__dir__) + "dumb_ai_player.rb"

class Configuration
  attr_reader :user_interface

  def initialize(user_interface)
    @user_interface = user_interface
    @unavailable_move_signatures = []
  end

  def configure_game
    user_interface.welcome_user
    modify_game_configuration = user_interface.modify_game_configuration?
    if modify_game_configuration
      get_custom_configuration
    else
      { user_interface: user_interface, board: Board.new(3), player_1: HumanPlayer.new("X", user_interface), player_2: DumbAiPlayer.new("O") }
    end
  end

  def get_custom_configuration
    board_side_length = user_interface.get_board_side_length
    player_1 = get_player_info(1)
    player_2 = get_player_info(2)

    { user_interface: user_interface, board: Board.new(board_side_length), player_1: player_1, player_2: player_2 }
  end

  def get_player_info(num)
    player_type = user_interface.get_player_type(num)
    player_move_signature = user_interface.get_player_move_signature(num, @unavailable_move_signatures)
    @unavailable_move_signatures << player_move_signature
    self.send(player_type, player_move_signature)
  end

  def human_player(move_signature)
    HumanPlayer.new(move_signature, user_interface)
  end

  def dumb_ai_player(move_signature)
    DumbAiPlayer.new(move_signature)
  end
end