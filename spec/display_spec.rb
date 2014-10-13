require 'display'

describe Display do
  let(:new_display) { described_class.new }

  describe "#display_board" do
    it "displays an array as a string" do
      board = Array.new(3) { [0, 0, 0] }
    end
  end

  describe "#get_move" do
    it "gets a move from the user" do
      allow(new_display).to receive(:print)
      allow(new_display).to receive(:gets) { "gets called" }
      expect(new_display.get_move).to eq("gets called")
    end
  end
end
