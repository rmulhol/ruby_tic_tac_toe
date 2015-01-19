class HumanPlayer
  attr_reader :move_signature, :user_interface

  def initialize(move_signature, user_interface)
    @move_signature = move_signature
    @user_interface = user_interface
  end

  def get_move(board)
    move_prompt = lambda { user_interface.request_move }
    valid_moves = lambda { |move| board.open_spaces.include?(move.to_i) }
    move = user_interface.get_validated_input(move_prompt, valid_moves)
    move.to_i
  end
end