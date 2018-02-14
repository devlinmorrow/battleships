require 'battleships'

describe Battleships do
  subject(:example_game) {Battleships.new}
  describe "display board" do
    it "should start with a box" do
      expect(example_game.box_mid).to include("1")
    end
    it "should display box 1" do
          expect{example_game.display_board}.to output(/1/).to_stdout
    end
    it "should display box 2" do
          expect{example_game.display_board}.to output(/2/).to_stdout
    end
  end
  describe "user selects box" do
    before do
      $stdin = StringIO.new("1")
    end
    it "should allow user to pick a number" do
      example_game.take_user_input
      expect(example_game.selected_box_number).to eql(1)
    end
    it "should mark the chosen number as attacked but missed" do
      example_game.mark_as_attacked_but_missed
      expect(example_game.box_mid[3]).to eq("☠")
    end
    it "should mark the chosen number as attacked and hit" do
      example_game.mark_as_attacked_and_hit
      expect(example_game.box_mid[3]).to eq("⚓")
    end
  end
end
