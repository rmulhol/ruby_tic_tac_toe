class MockBoard
  attr_reader :side_length, :board

  def initialize(side_length)
    @side_length = side_length
    @board = generate_board
  end

  def generate_board
    board = {}
    (1..side_length * side_length).each do |key|
      board[key] = nil
    end
    board
  end

  def player_wins?(player)
    nil
  end

  def place_move(space, move_signature)
    @board[space] = move_signature
  end
end