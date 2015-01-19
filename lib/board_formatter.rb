class BoardFormatter
  attr_reader :crlf

  def initialize
    @crlf = "\n"
  end

  def display_board_with_indexes(board)
    board_with_indexes = board_line(board)
    board.board.keys.each do |key|
      board_with_indexes += board_cell(key.to_s)
      if key % board.side_length == 0
        board_with_indexes += end_of_row(board)
      end
    end
    board_with_indexes
  end
 
  def display_board(board)
    board_display = board_line(board)
    board.board.keys.each do |key|
      board_display += board_cell(display_piece(board.board[key]))
      if key % board.side_length == 0
        board_display += end_of_row(board)
      end
    end
    board_display
  end

  def display_piece(value)
    value.nil? ? " " : value
  end

  def board_line(board)
    line = ""
    board.side_length.times do 
      line += "----"
    end
    line += "-" + crlf
  end

  def board_cell(value)
    if value.length == 1
      "| " + value + " "
    elsif value.length == 2
      "| " + value
    end
  end

  def end_of_row(board)
    "|" + crlf + board_line(board)
  end
end