require 'display'

describe Display do
  let(:new_display) { described_class.new }

  describe "#introduce_game" do
    it "prints a welcome message to the console" do
      allow(new_display).to receive(:puts) { "puts called" }
      expect(new_display.introduce_game).to eq("puts called")
    end
  end

  describe "#display_board" do
    it "prints the board to the console" do
      allow(new_display).to receive(:print)
      allow(new_display).to receive(:puts) { "puts called" }
      sample_board = [0, 0, 0, 0, 0, 0, 0, 0, 0]

      expect(new_display.display_board(sample_board)).to eq("puts called")
    end
  end

  describe "#prompt_for_X_move" do
    it "prints move request for player X to the console" do
      allow(new_display).to receive(:puts) { "puts called" }

      expect(new_display.prompt_for_X_move).to eq("puts called")
    end
  end

  describe "#prompt_for_O_move" do
    it "prints move request for player O to the console" do
      allow(new_display).to receive(:puts) { "puts called" }

      expect(new_display.prompt_for_O_move).to eq("puts called")
    end
  end

  describe "#get_move" do
    it "calls gets to get a move from the player" do
      allow(new_display).to receive(:gets) { "gets called" }
      expect(new_display.get_move).to eq("gets called")
    end
  end

  describe "#error_message" do
    it "prints error message to the console" do
      allow(new_display).to receive(:puts) { "puts called" }
      expect(new_display.error_message).to eq("puts called")
    end
  end

  describe "#announce_X_wins" do
    it "prints message that X wins to the console" do
      allow(new_display).to receive(:puts) { "puts called" }
      expect(new_display.announce_X_wins).to eq("puts called")
    end
  end

  describe "#announce_O_wins" do
    it "prints message that O wins to the console" do
      allow(new_display).to receive(:puts) { "puts called" }
      expect(new_display.announce_O_wins).to eq("puts called")
    end
  end

  describe "#announce_tie_game" do
    it "prints message announcing tie game to the console" do
      allow(new_display).to receive(:puts) { "puts called" }
      expect(new_display.announce_tie_game).to eq("puts called")
    end
  end
end
