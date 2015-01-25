require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "board_formatter.rb"
require Pathname(__dir__) + "mocks" + "mock_board.rb"

class BoardFormatterTest < Minitest::Test

  def setup
    @board_formatter = BoardFormatter.new
    @board_3x3 = MockBoard.new(3)
    @board_4x4 = MockBoard.new(4)
    @crlf = "\n"
  end

  def test_display_board_with_indexes
    board_with_indexes_3x3 =  "-------------#{@crlf}" +
                              "| 1 | 2 | 3 |#{@crlf}" +
                              "-------------#{@crlf}" +
                              "| 4 | 5 | 6 |#{@crlf}" +
                              "-------------#{@crlf}" +
                              "| 7 | 8 | 9 |#{@crlf}" +
                              "-------------#{@crlf}"
    assert_equal board_with_indexes_3x3, @board_formatter.display_board_with_indexes(@board_3x3)

    board_with_indexes_4x4 =  "-----------------#{@crlf}" +
                              "| 1 | 2 | 3 | 4 |#{@crlf}" +
                              "-----------------#{@crlf}" +
                              "| 5 | 6 | 7 | 8 |#{@crlf}" +
                              "-----------------#{@crlf}" +
                              "| 9 | 10| 11| 12|#{@crlf}" +
                              "-----------------#{@crlf}" +
                              "| 13| 14| 15| 16|#{@crlf}" +
                              "-----------------#{@crlf}"
    assert_equal board_with_indexes_4x4, @board_formatter.display_board_with_indexes(@board_4x4)
  end

  def test_display_board
    empty_board_3x3 = "-------------#{@crlf}" +
                      "|   |   |   |#{@crlf}" +
                      "-------------#{@crlf}" +
                      "|   |   |   |#{@crlf}" +
                      "-------------#{@crlf}" +
                      "|   |   |   |#{@crlf}" +
                      "-------------#{@crlf}"
    assert_equal empty_board_3x3, @board_formatter.display_board(@board_3x3), "display_board should portray empty 3x3 board"

    claimed_space_board_3x3 = "-------------#{@crlf}" +
                              "| X |   |   |#{@crlf}" +
                              "-------------#{@crlf}" +
                              "|   |   |   |#{@crlf}" +
                              "-------------#{@crlf}" +
                              "|   |   |   |#{@crlf}" +
                              "-------------#{@crlf}"
    @board_3x3.place_move(1, "X")
    assert_equal claimed_space_board_3x3, @board_formatter.display_board(@board_3x3), "display_board should portray 3x3 board with space(s) claimed"

    empty_board_4x4 = "-----------------#{@crlf}" +
                      "|   |   |   |   |#{@crlf}" +
                      "-----------------#{@crlf}" +
                      "|   |   |   |   |#{@crlf}" +
                      "-----------------#{@crlf}" +
                      "|   |   |   |   |#{@crlf}" +
                      "-----------------#{@crlf}" +
                      "|   |   |   |   |#{@crlf}" +
                      "-----------------#{@crlf}"
    assert_equal empty_board_4x4, @board_formatter.display_board(@board_4x4), "display_board should portray empty 4x4 board"

    claimed_space_board_4x4 = "-----------------#{@crlf}" +
                              "|   | O |   |   |#{@crlf}" +
                              "-----------------#{@crlf}" +
                              "|   |   |   |   |#{@crlf}" +
                              "-----------------#{@crlf}" +
                              "|   |   |   |   |#{@crlf}" +
                              "-----------------#{@crlf}" +
                              "|   |   |   |   |#{@crlf}" +
                              "-----------------#{@crlf}"
    @board_4x4.place_move(2, "O")
    assert_equal claimed_space_board_4x4, @board_formatter.display_board(@board_4x4), "display_board should portray a 4x4 board with space(s) claimed"
  end

  def test_display_piece
    assert_equal " ", @board_formatter.display_piece(nil), "display_piece should output a space if input is nil"
    assert_equal "X", @board_formatter.display_piece("X"), "display_piece should output input if input is not nil"
  end

  def test_board_line
    board_line_3x3 = "-------------#{@crlf}"
    board_line_4x4 = "-----------------#{@crlf}"

    assert_equal board_line_3x3, @board_formatter.board_line(@board_3x3), "board_line should output a line of 13 dashes for a 3x3 board"
    assert_equal board_line_4x4, @board_formatter.board_line(@board_4x4), "board_line should output a line of 17 dashes for a 4x4 board"
  end

  def test_board_cell
    assert_equal "|   ", @board_formatter.board_cell(" "), "board cell should show empty cell for single space input"
    assert_equal "| X ", @board_formatter.board_cell("X"), "board cell should show centered character for single character input"
    assert_equal "| 10", @board_formatter.board_cell("10"), "board_cell should eliminate trailing space for two character input"
  end

  def test_end_of_row
    end_of_row_3x3 = "|#{@crlf}-------------#{@crlf}"
    end_of_row_4x4 = "|#{@crlf}-----------------#{@crlf}"

    assert_equal end_of_row_3x3, @board_formatter.end_of_row(@board_3x3), "end_of_row should output a row ending and a board line for a 3x3 board"
    assert_equal end_of_row_4x4, @board_formatter.end_of_row(@board_4x4), "end_of_row should output a row ending and a board line for a 4x4 board"
  end
end