require 'battleships_game'

describe Battleships do
  describe "#take_user_input" do
    it "stores user input" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.take_user_input

      expect(example_game.selected_box_coordinates).to eql("A1")
    end
  end

  describe "#convert_coordinates" do
    it "converts input to grid coordinates" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.take_user_input
      expect(example_game.convert_coordinates).to eql([1,1])
    end
  end

  describe "#mark_as_hit_or_miss" do
    context "when attack is a hit" do
      it "displays target coordinates as a hit on the grid" do
        input = StringIO.new("A9")
        example_game = Battleships.new(input)

        example_game.take_user_input
        example_game.mark_as_hit_or_miss

        expect(example_game.game_grid.grid[9][1]).to eql("║  ⚓  ║")
      end

      it "marks boat 5 part 1 as hit" do
        input = StringIO.new("E6")
        example_game = Battleships.new(input)

        example_game.take_user_input
        example_game.mark_as_hit_or_miss

        expect(example_game.game_grid.grid[6][5]).to eql("║  ⚓  ║")
      end
    end

    context "when attack is a miss" do 
      it "marks A1 as attacked but missed" do
        input = StringIO.new("A1")
        example_game = Battleships.new(input)

        example_game.take_user_input
        example_game.mark_as_hit_or_miss

        expect(example_game.game_grid.grid[1][1]).to eql("║  ☠  ║")
      end
    end
  end

  describe "mark_if_boat_sunk" do
    context "when boat 1 is sunk" do
      it "returns true" do
        input = StringIO.new("A9")
        example_game = Battleships.new(input)

        example_game.take_user_input
        example_game.mark_as_hit_or_miss
        example_game.mark_if_boat_sunk

        expect(example_game.boat_list[:boat_1][0]).to eql(true)
      end
    end
  end

  describe "#game_is_won" do
    context "when all boats hit" do
      it "makes game is won condition true" do
        example_game = Battleships.new

        example_game.boat_list.each_value do |value|
          value[0] = true
        end
        example_game.game_is_won

        expect(example_game.game_is_won).to eql(true)
      end
    end

    context "when not all boats hit" do
      it "keeps the game is won condition false" do
        example_game = Battleships.new

        example_game.game_is_won

        expect(example_game.game_is_won).to eql(false)
      end
    end
  end

  describe "playing the game" do
    it "minuses one guess after guess made" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.guesses_left = 1
      example_game.play_game

      expect(example_game.guesses_left).to eq(0)
    end
  end

  describe "winning the game" do
    it "outputs 'won'" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.boat_list.each_value do |value|
        value[0] = true
      end
      example_game.game_is_won
      example_game.play_game

      expect(@output.string).to include("won")
    end
  end

  describe "losing the game" do
    it "states that you lost" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)
      example_game.guesses_left = 0

      example_game.play_game

      expect(@output.string).to include("lost")
    end
  end

end
