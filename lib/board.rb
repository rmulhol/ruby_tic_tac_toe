class Board
  attr_accessor :board, :number

  def initialize
    @board = create_empty_board
    @number = 0
  end
  
  def create_empty_board
    Array.new(9) { 0 }
  end

  def space_is_available?(move)
    board[move] == 0
  end

  def input_is_valid?(move)
    move.to_i != 0 || move.strip == "0"
  end

  def place_move(move)
    @number += 1
    board[move] = number
    board
  end

  def winning_combinations
    [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  end

  def player_O_wins?
    winners = winning_combinations
    check_array = winners.map do |winner|
      winner.map do |index|
        board[index].odd?
      end
    end
    check_array.include? [true, true, true]
  end

  def player_X_wins?
    winners = winning_combinations
    check_array = winners.map do |winner|
      winner.map do |index|
        board[index].even? && board[index] != 0
      end
    end
    check_array.include? [true, true, true]
  end

  def tie_game?
    !board.include? 0
  end

  def game_over?
    player_O_wins? || player_X_wins? || tie_game?
  end
end
