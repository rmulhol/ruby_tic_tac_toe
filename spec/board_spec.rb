require 'board'

describe Board do
  let(:new_board) { described_class.new }
  let(:board) { new_board.board }

  describe "#create_empty_board" do
    let(:empty_board) { new_board.create_empty_board }

    it "creates an array with nine spaces" do
      expect(empty_board.class).to eq(Array)
      expect(empty_board.length).to eq(9)
    end
  end

  describe "#space_is_available" do
    it "returns true when a space is empty" do
      expect(new_board.space_is_available?(0)).to be true
    end

    it "returns false when a space is not empty" do
      board[0] = 1
      expect(new_board.space_is_available?(0)).to be false
    end
  end

  describe "#input_is_valid" do
    it "allows integers" do
      expect(new_board.input_is_valid?("0")).to be true
      expect(new_board.input_is_valid?("1")).to be true
      expect(new_board.input_is_valid?("2")).to be true
    end

    it "reject extraneous strings" do
      expect(new_board.input_is_valid?("string")).to be false
      expect(new_board.input_is_valid?("\n")).to be false
    end
  end

  describe "#place_move" do
    it "fills designated space with a value" do
      placed_move = new_board.place_move(0)
      expected_return = [1, 0, 0, 0, 0, 0, 0, 0, 0]

      expect(placed_move).to eq(expected_return)
    end

    it "fills spaces sequentially" do
      new_board.place_move(1)
      new_board.place_move(2)
      expected_return = [0, 1, 2, 0, 0, 0, 0, 0, 0]

      expect(new_board.board).to eq(expected_return)
    end
  end


end
