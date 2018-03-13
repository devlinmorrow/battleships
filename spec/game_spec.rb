require 'game'

describe Battleships do
  describe "#create_boat_list" do
    it "returns array of boats" do
      example_game = Battleships.new

      expect(example_game.boat_list[0]).to eql(example_game.boat_1)
    end
  end

  describe "#guesses_and_boats_left_message" do
    it "outputs how many guesses are left" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)
      example_game.guesses_left = 1

      example_game.guesses_and_boats_left_message

      expect(@output.string).to include("1 guess")
    end

    it "outputs how many boats are left to sink" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.guesses_and_boats_left_message

      expect(@output.string).to include("9 boats")
    end
  end

  describe "#take_user_input" do
    it "stores user input" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.take_user_input

      expect(example_game.selected_box_coordinates).to eql("A1")
    end
  end

  describe "#check_if_input_correct_format" do
    context "input is in correct format" do
      it "returns true" do
        example_game = Battleships.new

        expect(example_game.check_if_input_correct_format("A1")).to eql(true)
      end
    end

    context "input does not contain a letter" do
    end
  end

  describe "#mark_as_hit_or_miss" do
    context "when the attack is a hit" do
      it "marks the first element of boat 5 as a hit" do
        input = StringIO.new("E6")
        example_game = Battleships.new(input)

        example_game.take_user_input
        example_game.mark_as_hit_or_miss

        expect(example_game.game_grid.grid[6][5]).to eql("║  ⚓  ║")
      end
    end

    context "when the attack is a miss" do 
      it "marks A1 as a miss" do
        input = StringIO.new("A1")
        example_game = Battleships.new(input)

        example_game.take_user_input
        example_game.mark_as_hit_or_miss

        expect(example_game.game_grid.grid[1][1]).to eql("║  ☠  ║")
      end
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

  describe "#state_if_hit_or_miss" do
    context "when attack was a hit" do
      it "outputs hit message" do
        input = StringIO.new("A9")
        @output = StringIO.new
        example_game = Battleships.new(input, @output)

        example_game.take_user_input
        example_game.state_if_hit_or_miss

        expect(@output.string).to include("got one")
      end
    end

    context "when attack was a miss" do
      it "outputs miss message" do
        input = StringIO.new("A1")
        @output = StringIO.new
        example_game = Battleships.new(input, @output)

        example_game.take_user_input
        example_game.state_if_hit_or_miss

        expect(@output.string).to include("miss")
      end
    end
  end

  describe "#state_if_any_boat_sunk" do
    it "outputs that boat has been sunk" do
      input = StringIO.new("A9")
      @output = StringIO.new
      example_game = Battleships.new(input, @output)
      example_game.guesses_left = 1

      example_game.take_user_input
      example_game.hit?
      example_game.state_if_any_boat_sunk

      expect(@output.string).to include("sank")
    end
  end

  describe "#decrease_guesses_left_if_not_hit" do
    context "when attack was a hit" do
      it "does not minus one guess from guesses left" do
        input = StringIO.new("A9")
        example_game = Battleships.new(input)
        example_game.guesses_left = 1

        example_game.take_user_input
        example_game.hit?
        example_game.decrease_guesses_left_if_not_hit

        expect(example_game.guesses_left).to eq(1)
      end
    end

    context "when attack was a miss" do
      it "minuses one guess from guesses left" do
        input = StringIO.new("A1")
        example_game = Battleships.new(input)
        example_game.guesses_left = 1

        example_game.take_user_input
        example_game.hit?
        example_game.decrease_guesses_left_if_not_hit

        expect(example_game.guesses_left).to eq(0)
      end
    end
  end

  describe "#make_guesses" do
    it "runs until there are no guesses left" do
      input = StringIO.new("A1\nA2")
      example_game = Battleships.new(input)
      example_game.guesses_left = 2

      example_game.make_guesses

      expect(example_game.guesses_left).to eql(0)
    end
  end

  describe "#game_is_won" do
    context "when all boats sunk" do
      it "returns true" do
        example_game = Battleships.new

        example_game.boat_list.each do |boat|
          boat.boat_coords_hash.each_key do |key|
            boat.boat_coords_hash[key] = true
          end
        end

        expect(example_game.game_is_won).to eql(true)
      end
    end

    context "when not all boats sunk" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.game_is_won).to eql(false)
      end
    end
  end

  describe "winning the game" do
    it "outputs 'won'" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.boat_list.each do |boat|
        boat.boat_coords_hash.each_key do |key|
          boat.boat_coords_hash[key] = true
        end
      end
      example_game.play_game

      expect(@output.string).to include("won")
    end
  end

  describe "losing the game" do
    it "outputs 'lost'" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)
      example_game.guesses_left = 0

      example_game.play_game

      expect(@output.string).to include("lost")
    end
  end
end
