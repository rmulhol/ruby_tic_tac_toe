require 'runner'
require 'mock_board'
require 'mock_display'

describe Runner do
  let(:new_game) { described_class.new(MockBoard.new, MockDisplay.new) }

  describe "#get_move" do
    it "prompts the user for a move" do
      allow(new_game).to receive(:get_move) { "gets called" }

      expect(new_game.get_move).to eq("gets called")
    end
  end

  describe "#place_move" do
    it "sends a message to board" do
      expect(new_game.place_move(0)).to eq("place move called")
    end
  end

  describe "#display_board" do
    it "sends a message to display" do
      expect(new_game.display_board("board")).to eq("display board called")
    end
  end
end
