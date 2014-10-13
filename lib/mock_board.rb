class MockBoard
  def create_empty_board
  end

  def space_is_available?(move)
    true
  end

  def place_move(move)
    "place move called"
  end
end
