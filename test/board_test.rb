require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "board.rb"

class BoardTest < Minitest::Test
  
  def setup
    @board_3x3 = Board.new(3)
    @board_4x4 = Board.new(4)
  end

  def test_side_length
    assert_equal 3, @board_3x3.side_length, "Side length instance variable should store board side length as integer"
    assert_equal 4, @board_4x4.side_length, "Side length instance variable should store board side length as integer"
  end
  
  def test_board
    board_3x3 = { 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    board_4x4 = { 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil, 10 => nil, 11 => nil, 12 => nil, 13 => nil, 14 => nil, 15 => nil, 16 => nil }

    assert_equal board_3x3, @board_3x3.board, "Board instance variable should store board as hash"
    assert_equal board_4x4, @board_4x4.board, "Board instance variable should store board as hash"
  end

  def test_place_move
    @board_3x3.place_move(1, "X")
    @board_4x4.place_move(1, "O")

    board_with_move_placed_3x3 = { 1 => "X", 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    board_with_move_placed_4x4 = { 1 => "O", 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil, 10 => nil, 11 => nil, 12 => nil, 13 => nil, 14 => nil, 15 => nil, 16 => nil }

    assert_equal board_with_move_placed_3x3, @board_3x3.board, "Board instance variable should show space as claimed after move is placed"
    assert_equal board_with_move_placed_4x4, @board_4x4.board, "Board instance variable should show space as claimed after move is placed"
  end

  def test_open_spaces
    @board_3x3.place_move(1, "X")
    @board_4x4.place_move(1, "O")

    open_spaces_3x3 = [2, 3, 4, 5, 6, 7, 8, 9]
    open_spaces_4x4 = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]

    assert_equal open_spaces_3x3, @board_3x3.open_spaces, "All remaining spaces should be open if only space 1 is claimed"
    assert_equal open_spaces_4x4, @board_4x4.open_spaces, "All remaining spaces should be open if only space 1 is claimed"
  end

  def test_game_over
    claim_all_spaces(@board_3x3)
    claim_all_spaces(@board_4x4)

    assert @board_3x3.game_over?("X", "O"), "game_over? should return true if all spaces claimed on a 3x3 board"
    assert @board_4x4.game_over?("X", "O"), "game_over? should return true if all spaces claimed on a 4x4 board"

    @board_3x3.clear_board
    @board_4x4.clear_board

    claim_row(@board_3x3, "X")
    claim_row(@board_4x4, "O")

    assert @board_3x3.game_over?("X", "O"), "game_over? should return true if player wins on 3x3 board"
    assert @board_4x4.game_over?("X", "O"), "game_over? should return true if player wins on 4x4 board"
  end

  def claim_all_spaces(board)
    (1..board.size).each do |key|
      board.place_move(key, "X")
    end
  end

  def test_player_wins
    assert !@board_3x3.player_wins?("X"), "player wins should return false if no spaces claimed on a 3x3 board"
    assert !@board_4x4.player_wins?("O"), "player_wins should return false if no spaces claimed on a 4x4 board"

    claim_row(@board_3x3, "X")
    claim_row(@board_4x4, "O")
    
    assert @board_3x3.player_wins?("X"), "player_wins should return true if X is placed on every space in a row on a 3x3 board"
    assert @board_4x4.player_wins?("O"), "player_wins should return true if O is places on every space in a row on a 4x4 board"
    
    @board_3x3.clear_board
    @board_4x4.clear_board

    claim_column(@board_3x3, "X")
    claim_column(@board_4x4, "O")

    assert @board_3x3.player_wins?("X"), "player_wins should return true if X is placed on every space in a column on a 3x3 board"
    assert @board_4x4.player_wins?("O"), "player_wins should return true if O is places on every space in a column on a 4x4 board"

    @board_3x3.clear_board
    @board_4x4.clear_board

    claim_diagonal(@board_3x3, "X")
    claim_diagonal(@board_4x4, "O")

    assert @board_3x3.player_wins?("X"), "player_wins should return true if X is placed on every space in a diagonal on a 3x3 board"
    assert @board_4x4.player_wins?("O"), "player_wins should return true if O is placed on every space in a diagonal on a 4x4 board"
  end

  def claim_row(board, move_signature)
    (1..board.side_length).each do |key|
      board.place_move(key, move_signature)
    end
  end

  def claim_column(board, move_signature)
    board.column_starting_at(1).each do |key|
      board.place_move(key, move_signature)
    end
  end

  def claim_diagonal(board, move_signature)
    board.left_to_right_diagonal.each do |key|
      board.place_move(key, move_signature)
    end
  end

  def test_clear_board
    @board_3x3.place_move(1, "X")
    @board_4x4.place_move(2, "0")
    
    @board_3x3.clear_board
    @board_4x4.clear_board

    assert @board_3x3.board.values.all? { |value| value.nil? }
    assert @board_4x4.board.values.all? { |value| value.nil? }
  end

  def test_winning_combinations
    winning_combinations_3x3 = [[1, 2, 3,], [4, 5, 6], [7, 8, 9],
                                [1, 4, 7], [2, 5, 8], [3, 6, 9],
                                [1, 5, 9], [3, 5, 7]]
    winning_combinations_4x4 = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16],
                                [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16],
                                [1, 6, 11, 16], [4, 7, 10, 13]]

    assert_equal winning_combinations_3x3, @board_3x3.winning_combinations, "winning_combinations should return all winning combinations for a 3x3 board"
    assert_equal winning_combinations_4x4, @board_4x4.winning_combinations, "winning_combinations should return all winning combinations for a 4x4 board"
  end

  def test_rows
    rows_3x3 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    rows_4x4 = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]

    assert_equal rows_3x3, @board_3x3.rows, "rows should return [[1, 2, 3], [4, 5, 6], [7, 8, 9]] for a 3x3 board"
    assert_equal rows_4x4, @board_4x4.rows, "rows should return [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]] for a 4x4 board"
  end


  def test_columns
    columns_3x3 = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
    columns_4x4 = [[1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16]]

    assert_equal columns_3x3, @board_3x3.columns, "columns should return [[1, 4, 7], [2, 5, 8], [3, 6, 9]] for a 3x3 board"
    assert_equal columns_4x4, @board_4x4.columns, "columns should return [[1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16]] for a 4x4 board"
  end

  def test_diagonals
    diagonals_3x3 = [[1, 5, 9], [3, 5, 7]]
    diagonals_4x4 = [[1, 6, 11, 16], [4, 7, 10, 13]]

    assert_equal diagonals_3x3, @board_3x3.diagonals, "diagonals should return [[1, 5, 9], [3, 5, 7]] for a 3x3 board"
    assert_equal diagonals_4x4, @board_4x4.diagonals, "diagonals should return [[1, 6, 11, 16], [4, 7, 10, 13]] for a 4x4 board"
  end

  def test_size
    assert_equal 9, @board_3x3.size, "Board with side length 3 should be of.board.size 9"
    assert_equal 16, @board_4x4.size, "Board with side length 4 should be of.board.size 16"
  end

  def test_creates_empty_board
    empty_board_3x3 = { 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil }
    empty_board_4x4 = { 1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil, 10 => nil, 11 => nil, 12 => nil, 13 => nil, 14 => nil, 15 => nil, 16 => nil }

    assert_equal empty_board_3x3, @board_3x3.create_empty_board, "Empty board should have 9 keys with value of nil"
    assert_equal empty_board_4x4, @board_4x4.create_empty_board, "Empty board should have 16 keys with value of nil"
  end

  def test_column_starting_at
    column_starting_at_1_3x3 = [1, 4, 7]
    column_starting_at_2_3x3 = [2, 5, 8]
    column_starting_at_3_3x3 = [3, 6, 9]
    column_starting_at_1_4x4 = [1, 5, 9, 13]
    column_starting_at_2_4x4 = [2, 6, 10, 14]
    column_starting_at_3_4x4 = [3, 7, 11, 15]
    column_starting_at_4_4x4 = [4, 8, 12, 16]

    assert_equal column_starting_at_1_3x3, @board_3x3.column_starting_at(1), "column_starting_at 1 should return [1, 4, 7] for a 3x3 board"
    assert_equal column_starting_at_2_3x3, @board_3x3.column_starting_at(2), "column_starting_at 2 should return [2, 5, 8] for a 3x3 board"
    assert_equal column_starting_at_3_3x3, @board_3x3.column_starting_at(3), "column_starting_at 3 should return [3, 6, 9] for a 3x3 board"
    assert_equal column_starting_at_1_4x4, @board_4x4.column_starting_at(1), "column_starting_at 1 should return [1, 5, 9, 13] for a 4x4 board"
    assert_equal column_starting_at_2_4x4, @board_4x4.column_starting_at(2), "column_starting_at 2 should return [2, 6, 10, 14] for a 4x4 board"
    assert_equal column_starting_at_3_4x4, @board_4x4.column_starting_at(3), "column_starting_at 3 should return [3, 7, 11, 15] for a 4x4 board"
    assert_equal column_starting_at_4_4x4, @board_4x4.column_starting_at(4), "column_starting_at 4 should return [4, 8, 12, 16] for a 4x4 board"
  end

  def test_left_to_right_diagonal
    diagonal_3x3 = [1, 5, 9]
    diagonal_4x4 = [1, 6, 11, 16]

    assert_equal diagonal_3x3, @board_3x3.left_to_right_diagonal, "left_to_right_diagonal should return [1, 5, 9] for a 3x3 board"
    assert_equal diagonal_4x4, @board_4x4.left_to_right_diagonal, "left_to_right_diagonal should return [1, 6, 11, 16] for a 4x4 board"
  end

  def test_right_to_left_diagonal
    diagonal_3x3 = [3, 5, 7]
    diagonal_4x4 = [4, 7, 10, 13]

    assert_equal diagonal_3x3, @board_3x3.right_to_left_diagonal, "right_to_left_diagonal should return [3, 5, 7] for a 3x3 board"
    assert_equal diagonal_4x4, @board_4x4.right_to_left_diagonal, "right_to_left_diagonal should return [4, 7, 10, 13] for a 4x4 board"
  end

  def test_diagonal
    left_to_right_diagonal_3x3 = [1, 5, 9]
    left_to_right_diagonal_4x4 = [1, 6, 11, 16]
    right_to_left_diagonal_3x3 = [3, 5, 7]
    right_to_left_diagonal_4x4 = [4, 7, 10, 13]

    assert_equal left_to_right_diagonal_3x3, @board_3x3.diagonal(1, 1), "diagonal should return [1, 5, 9] for a 3x3 board with first cell 1, increment value 1"
    assert_equal left_to_right_diagonal_4x4, @board_4x4.diagonal(1, 1), "diagonal should return [1, 6, 11, 16] for a 4x4 board with first cell 1, increment value 1"
    assert_equal right_to_left_diagonal_3x3, @board_3x3.diagonal(3, -1), "diagonal should return [3, 5, 7] for a 3x3 board with first cell 3, increment value -1"
    assert_equal right_to_left_diagonal_4x4, @board_4x4.diagonal(4, -1), "diagonal should return [4, 7, 10, 13] for a 4x4 board with first cell 4, increment value -1"
  end 
end
