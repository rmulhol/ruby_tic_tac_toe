class Board
  attr_reader :side_length, :board

  def initialize(side_length)
    @side_length = side_length
    @board = create_empty_board
  end

  def place_move(space, move_signature)
    @board[space] = move_signature
  end

  def open_spaces
    board.select { |key, value| value.nil? }.keys
  end

  def game_over?(player_1_move_signature, player_2_move_signature)
    open_spaces.empty? || player_wins?(player_1_move_signature) || player_wins?(player_2_move_signature)
  end

  def player_wins?(move_signature)
    winning_combinations.any? do |winning_combination|
      board.select do |key, value|
        winning_combination.include?(key) && value == move_signature
      end
      .length == side_length
    end
  end

  def clear_board
    (1..size).each do |key|
      place_move(key, nil)
    end
  end

  # private

  def winning_combinations
    rows + columns + diagonals
  end

  def rows
    (1..board.size).each_slice(side_length).to_a
  end

  def columns
    (1..side_length).map do |first_cell|
      column_starting_at(first_cell)
    end
  end

  def diagonals
    [left_to_right_diagonal, right_to_left_diagonal]
  end

  def size
    side_length * side_length
  end

  def create_empty_board
    (1..size).map { |num| [num, nil] }.to_h
  end
  
  def column_starting_at(num)
    column = []
    side_length.times do
      column << num
      num += side_length
    end
    column
  end

  def left_to_right_diagonal
    diagonal(1, 1)
  end

  def right_to_left_diagonal
    diagonal(side_length, -1)
  end

  def diagonal(first_cell, increment_value)
    diagonal = []
    side_length.times do
      diagonal << first_cell
      first_cell += side_length + increment_value
    end
    diagonal
  end
end