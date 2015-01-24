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
      score = minimax(board, false, opponent, 1)
      if score > top_score
        top_score = score
        move_index = space
      end
      board.place_move(space, nil)
    end

    move_index
  end

  def minimax(board, my_turn, opponent, depth)
    return score_board(board, opponent) / depth if board.game_over?(move_signature, opponent)

    best_score = -100.0
    worst_score = 100.0

    if my_turn
      board.open_spaces.each do |space|
        board.place_move(space, move_signature)
        score = minimax(board, false, opponent, depth + 1)
        if score > best_score
          best_score = score
        end
        board.place_move(space, nil)
      end  
      
      return best_score
    else
      board.open_spaces.each do |space|
        board.place_move(space, opponent)
        score = minimax(board, true, opponent, depth + 1)
        if score < worst_score
          worst_score = score
        end
        board.place_move(space, nil)
      end
      
      return worst_score
    end
  end

  def score_board(board, opponent)
    if board.player_wins?(move_signature)
      10.0
    elsif board.player_wins?(opponent)
      -10.0
    else
      0.0
    end
  end

  def get_opponent(board)
    opponent = board.board.values.select { |val| val != move_signature }.compact.sample || :no_opponent_move
  end
end