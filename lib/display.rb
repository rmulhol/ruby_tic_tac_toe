class Display
  attr_reader :rows, :columns

  def initialize
    @rows = 3
    @columns = 3
  end

  def introduce_game
    puts "Hello and welcome to Tic Tac Toe!"
    puts "This game is configured for human vs human play."
    puts "When prompted, enter the index for the space you want to claim."
    puts "The indexes are allocated like so: 
            |---|---|---|
            | 0 | 1 | 2 |
            |---|---|---|
            | 3 | 4 | 5 |
            |---|---|---|
            | 6 | 7 | 8 |
            |---|---|---|\n"
  end

  def display_board(board)
    counter = 0
    rows.times do 
      puts "|---|---|---|"
      columns.times do
        if board[counter] == 0
          print "|   "
        elsif board[counter].even?
          print "| X "
        else
          print "| O "
        end
        counter += 1
      end
      puts "|"
    end
    puts "|---|---|---|"
  end

  def prompt_for_X_move
    puts "Enter move for player X: "
  end

  def prompt_for_O_move
    puts "Enter move for player O: "
  end

  def get_move
    space = gets
  end

  def error_message
    puts "Invalid input. Try again: "
  end

  def announce_X_wins
    puts "X wins!"
  end

  def announce_O_wins
    puts "O wins!"
  end

  def announce_tie_game
    puts "Tie game!"
  end
end
