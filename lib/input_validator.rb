class InputValidator
  def valid_board_side_length?(side_length)
    return_boolean side_length =~ /\A[3-9]\z/
  end

  def valid_player_type?(player_type)
    human_player?(player_type) || 
    beatable_ai_player?(player_type) ||
    unbeatable_ai_player?(player_type)
  end

  def human_player?(player_type)
    return_boolean player_type =~ /1|human/i
  end

  def beatable_ai_player?(player_type)
    return_boolean player_type =~ /^[2|beatable]/i
  end

  def unbeatable_ai_player?(player_type)
    return_boolean player_type =~ /3|unbeatable/i
  end

  def response_is_affirmative?(response)
    return_boolean response =~ /^y/i
  end

  def return_boolean(result)
    !!(result)
  end
end