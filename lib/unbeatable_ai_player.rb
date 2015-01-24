class UnbeatableAiPlayer
  attr_reader :move_signature

  def initialize(move_signature)
    @move_signature = move_signature
  end

  def get_move(board)
    opponent = get_opponent(board)
    return 1 if opponent == :no_opponent_move

    top_score = -100.0
    move_index = nil

    board.open_spaces.each do |space|
      board.place_move(space, move_signature)
      score = negamax(board, false, opponent, 100, -100)
      if score > top_score
        top_score = score
        move_index = space
      end
      board.place_move(space, nil)
    end

    move_index
  end

  def negamax(board, my_turn, opponent, alpha, beta)
    return score_board(board, opponent) if board.game_over?(move_signature, opponent)

    board.open_spaces.each do |space|
      my_turn ? board.place_move(space, move_signature) : board.place_move(space, opponent)
      score = -negamax(board, !my_turn, opponent, -beta, -alpha)
      if score < alpha
        alpha = score
      end
      board.place_move(space, nil)
      break if alpha <= beta
    end

    return alpha
  end

  def score_board(board, opponent)
    if board.player_wins?(move_signature) || board.player_wins?(opponent)
      10.0
    else
      0.0
    end
  end

  def get_opponent(board)
    opponent = board.board.values.select { |val| val != move_signature }.compact.sample || :no_opponent_move
  end
end