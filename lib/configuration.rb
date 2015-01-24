require "pathname"
require Pathname(__dir__) + "board.rb"
require Pathname(__dir__) + "human_player.rb"
require Pathname(__dir__) + "beatable_ai_player.rb"
require Pathname(__dir__) + "unbeatable_ai_player.rb"

class Configuration
  attr_reader :user_interface, :game_configuration

  def initialize(user_interface, game_configuration)
    @user_interface = user_interface
    @game_configuration = game_configuration
  end

  def configure_game
    board = Board.new(game_configuration.fetch(:board_side_length))
    player_1 = player(game_configuration.fetch(:player_1))
    player_2 = player(game_configuration.fetch(:player_2))
    Runner.new(user_interface, board, player_1, player_2)
  end

  def player(player)
    player_type = player.fetch(:player_type)
    move_signature = player.fetch(:move_signature)
    self.send(player_type, move_signature)
  end

  def human_player(move_signature)
    HumanPlayer.new(move_signature, user_interface)
  end

  def beatable_ai_player(move_signature)
    BeatableAiPlayer.new(move_signature)
  end

  def unbeatable_ai_player(move_signature)
    UnbeatableAiPlayer.new(move_signature)
  end
end