require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "beatable_ai_player.rb"
require Pathname(__dir__).parent + "lib" + "board.rb"

class BeatableAiPlayerTest < Minitest::Test

  def setup
    @ai_player = BeatableAiPlayer.new("X")
  end

  def test_get_move
    @board_3x3 = Board.new(3)

    assert_includes (1..9).to_a, @ai_player.get_move(@board_3x3), "get_move should return a random number from the indexes available on the board"
  end
end