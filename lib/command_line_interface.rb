class CommandLineInterface
  attr_reader :io, :messages, :board_formatter, :input_validator

  def initialize(io, messages, board_formatter, input_validator)
    @io = io
    @messages = messages
    @board_formatter = board_formatter
    @input_validator = input_validator
    @unavailable_move_signatures = []
  end


  def get_game_configuration
    welcome_user
    modify_game_configuration = modify_game_configuration?
    if modify_game_configuration
      get_custom_game_configuration
    else
      { board_side_length: 3, 
        player_1: { type: :human_player, move_signature: "X" }, 
        player_2: { type: :unbeatable_ai_player, move_signature: "O" } }
    end
  end

  def get_custom_game_configuration
    board_side_length = get_board_side_length
    player_1 = get_player_info(1)
    player_2 = get_player_info(2)

    { board_side_length: board_side_length, 
      player_1: player_1, 
      player_2: player_2 }
  end

  def get_player_info(num)
    player_type = get_player_type(num)
    player_move_signature = get_player_move_signature(num, @unavailable_move_signatures)
    
    @unavailable_move_signatures << player_move_signature
    
    { type: player_type, 
      move_signature: player_move_signature }
  end

  def welcome_user
    io.puts(messages.welcome_user)
  end

  def modify_game_configuration?
    io.puts(messages.offer_to_modify_game_configuration)
    response = io.get_input
    input_validator.response_is_affirmative?(response)
  end

  def describe_board_configuration(board)
    io.puts(messages.introduce_board(board))
    io.puts(board_formatter.display_board_with_indexes(board))
  end

  def get_board_side_length
    board_side_length_prompt = lambda { io.puts(messages.request_board_side_length) }
    board_side_length_condition = lambda { |side| input_validator.valid_board_side_length?(side) }
    board_side_length = get_validated_input(board_side_length_prompt, board_side_length_condition)
    board_side_length.to_i
  end

  def get_player_type(num)
    player_type_prompt = lambda { io.puts(messages.request_player_type(num)) }
    player_type_condition = lambda { |type| input_validator.valid_player_type?(type) }
    player_type = get_validated_input(player_type_prompt, player_type_condition)
    return_player_type(player_type)
  end

  def return_player_type(player_type)
    if input_validator.human_player?(player_type)
      :human_player
    elsif input_validator.beatable_ai_player?(player_type)
      :beatable_ai_player
    elsif input_validator.unbeatable_ai_player?(player_type)
      :unbeatable_ai_player
    end
  end

  def get_player_move_signature(num, unavailable_move_signatures)
    io.puts(messages.request_player_move_signature(num))
    player_move_signature = io.get_input
    until player_move_signature.length == 1 && !unavailable_move_signatures.include?(player_move_signature)
      io.puts(messages.invalid_input)
      io.puts(messages.request_player_move_signature(num))
      player_move_signature = io.get_input
    end
    player_move_signature
  end

  def request_move
    io.puts(messages.request_move)
  end

  def announce_invalid_move
    io.puts(messages.announce_invalid_move)
  end

  def display_board(board)
    io.puts(board_formatter.display_board(board))
  end

  def announce_outcome(board, player_1_move_signature, player_2_move_signature)
    if board.player_wins?(player_1_move_signature)
      io.puts(messages.player_1_wins)
    elsif board.player_wins?(player_2_move_signature)
      io.puts(messages.player_2_wins)
    else
      io.puts(messages.tie_game)
    end
  end

  def play_again?
    io.puts(messages.offer_to_play_again)
    response = io.get_input
    input_validator.response_is_affirmative?(response)
  end

  def get_validated_input(prompt_lambda, condition_lambda)
    prompt_lambda.call
    input = io.get_input
    until condition_lambda.call(input)
      io.puts(messages.invalid_input)
      prompt_lambda.call
      input = io.get_input
    end
    input
  end
end