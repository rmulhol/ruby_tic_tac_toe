require "minitest/autorun"
require "pathname"
require Pathname(__dir__).parent + "lib" + "input_validator.rb"

class InputValidatorTest < Minitest::Test

  def setup
    @input_validator = InputValidator.new
  end

  def test_valid_board_side_length
    assert @input_validator.valid_board_side_length?("3"), "valid_board_side_length? should return true for 3 and up (up to 9)"
    assert @input_validator.valid_board_side_length?("9"), "valid_board_side_length? should return true for 9 and below (down to 3)"
    assert !@input_validator.valid_board_side_length?("2"), "valid_board_side_length? should return false for 2 and below"
    assert !@input_validator.valid_board_side_length?("10"), "valid_board_side_length? should return false for 10 and up"
  end

  def test_valid_player_type
    assert @input_validator.valid_player_type?("1"), "valid_player_type? should return true for '1'"
    assert @input_validator.valid_player_type?("2"), "valid_player_type? should return true for '2'"
    assert @input_validator.valid_player_type?("human"), "valid_player_type? should return true for 'human'"
    assert @input_validator.valid_player_type?("ai"), "valid_player_type? should return true for 'ai'"
    assert !@input_validator.valid_player_type?("non-valid"), "valid_player_type? should return false if input does not correspond to one of the available options"
  end

  def test_human_player
    assert @input_validator.human_player?("1"), "human_player? should return true for '1'"
    assert @input_validator.human_player?("human"), "human_player? should return true for 'human'"
    assert @input_validator.human_player?("HuMaN"), "human_player? should be case-insensitive to return true for 'HuMaN'"
    assert !@input_validator.human_player?("2"), "human_player? should return false for numbers other than 1"
    assert !@input_validator.human_player?("ai"), "human_player? should return false for strings other than 'human'"
  end

  def test_ai_player
    assert @input_validator.ai_player?("2"), "ai_player? should return true for '2'"
    assert @input_validator.ai_player?("ai"), "ai_player? should return true for 'ai'"
    assert @input_validator.ai_player?("aI"), "ai_player? should be case-insensitive and return true for 'aI'"
    assert !@input_validator.ai_player?("1"), "ai_player? should return false for numbers other than 2"
    assert !@input_validator.ai_player?("human"), "ai_player? should return false for strings other than 'ai'"
  end

  def test_response_is_affirmative
    assert @input_validator.response_is_affirmative?("yes"), "response_is_affirmative? should return true for 'yes'"
    assert !@input_validator.response_is_affirmative?("no"), "response_is_affirmative? should return false for 'no'"
  end
end