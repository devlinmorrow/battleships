require 'battleships'

describe Battleships do
  subject(:example_game) {Battleships.new}
  describe "set up  board" do
    it "should start with a box" do
      expect(example_game.box_row_2).to include("1")
    end
    it "should display box 1" do
      expect{example_game.display_board}.to output(/1/).to_stdout
    end
    it "should display box 8" do
      expect{example_game.display_board}.to output(/2/).to_stdout
    end
  end
  describe "user selects box" do
    it "should allow user to pick a number" do
      $stdin = StringIO.new("1")
      example_game.take_user_input
      expect(example_game.selected_box_number).to eql(1)
    end
  end
  describe "some boxes are hits some are misses" do
    it "should mark box 1 as attacked but missed" do
      example_game.selected_box_number = 1
      example_game.mark_as_hit_or_miss
      expect(example_game.box_row_2[3]).to eq("☠")
    end
    it "should mark box 2 as attacked and hit" do
      example_game.selected_box_number = 2
      example_game.mark_as_hit_or_miss
      expect(example_game.box_row_2[10]).to eq("⚓")
    end
    it "should mark box 4 as attacked but missed" do
      example_game.selected_box_number = 4
      example_game.mark_as_hit_or_miss
      expect(example_game.box_row_5[3]).to eq("☠")
    end
    it "should mark box 9 as attacked and hit" do
      example_game.selected_box_number = 9
      example_game.mark_as_hit_or_miss
      expect(example_game.box_row_8[17]).to eq("⚓")
    end
  end
end
