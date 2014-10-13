class Runner
  attr_accessor :game_board, :game_display
  
  def initialize(game_board, game_display)
    @game_board = game_board
    @game_display = game_display
  end

  def play_game
    game_display.introduce_game
    counter = 0
    until game_board.game_over?
      if counter.even?
        o_move
      else
        x_move
      end
      counter += 1
    end
    end_game
  end

  def o_move
    game_display.prompt_for_O_move
    move_O = get_move
    place_move(move_O.to_i)
    display_board(game_board.board)
  end

  def x_move
    game_display.prompt_for_X_move
    move_X = get_move
    place_move(move_X.to_i)
    display_board(game_board.board)
  end

  def end_game
    if game_board.player_X_wins?
      game_display.announce_X_wins
    elsif game_board.player_O_wins?
      game_display.announce_O_wins
    elsif game_board.tie_game?
      game_display.announce_tie_game
    end
  end

  def get_move
    move = game_display.get_move
    until move_is_valid?(move)
      game_display.error_message
      move = game_display.get_move
    end
    move
  end

  def move_is_valid?(move)
    game_board.space_is_available?(move.to_i) && game_board.input_is_valid?(move)
  end

  def place_move(move)
    game_board.place_move(move)
  end

  def display_board(board)
    game_display.display_board(board) 
  end
end
