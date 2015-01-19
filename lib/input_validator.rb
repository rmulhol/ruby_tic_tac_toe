class InputValidator
  def valid_board_side_length?(side_length)
    return_boolean side_length =~ /\A[3-9]\z/
  end

  def valid_player_type?(player_type)
    human_player?(player_type) || ai_player?(player_type)
  end

  def human_player?(player_type)
    return_boolean player_type =~ /1|human/i
  end

  def ai_player?(player_type)
    return_boolean player_type =~ /2|ai/i
  end

  def response_is_affirmative?(response)
    return_boolean response =~ /^y/i
  end

  def return_boolean(result)
    !!(result)
  end
end