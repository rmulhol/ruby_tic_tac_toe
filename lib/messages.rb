class Messages
  attr_reader :crlf

  def initialize
    @crlf = "\n"
  end

  def welcome_user
    "Welcome to Tic Tac Toe!"
  end

  def offer_to_modify_game_configuration
    "This game is set to run HvC on a 3x3 board. Would you like to modify these settings?"
  end

  def request_board_side_length
    "What size board would you like to play on? Please enter a number between 3 and 9."
  end

  def request_player_type(num)
    "What type of player would you like player #{num} to be? Choose from the following:
    1. Human player
    2. AI player"
  end

  def request_player_move_signature(num)
    "What will be the move signature for player #{num}? (e.g. X, O, etc.)"
  end

  def introduce_board(board)
    "This game will be played on a #{board.side_length}x#{board.side_length} board, indexed like so:"
  end

  def request_move
    "Which space would you like to claim?"
  end

  def announce_invalid_move
    "That is not a valid move. Please try again."
  end

  def player_1_wins
    "Player 1 wins!"
  end

  def player_2_wins
    "Player 2 wins!"
  end

  def tie_game
    "Tie game!"
  end

  def offer_to_play_again
    "Would you like to play again?"
  end

  def invalid_input
    "Sorry, I don't understand. Please try again."
  end
end