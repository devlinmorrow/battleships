require 'game'

describe BattleshipsGame do
  describe "#game_is_won" do
    context "when all boats sunk" do
      it "returns true" do
        example_game = BattleshipsGame.new
        example_game.game_boat_list = BoatList.new([@boat_1 = Boat.new([[1,1]])])

        @boat_1.record_hit([1,1])

        expect(example_game.game_is_won).to be true
      end
    end
  end

  context "when not all boats sunk" do
    it "returns false" do
      example_game = BattleshipsGame.new
      example_game.game_boat_list = BoatList.new([@boat_1 = Boat.new([[1,1]])])

      expect(example_game.game_is_won).to be false
    end
  end

  describe "#guesses_and_boats_left_message" do
    context "when there are 3 guesses left" do
      it "outputs 3 guesses left" do
        input = StringIO.new
        @output = StringIO.new
        example_game = BattleshipsGame.new(input, @output)
        example_game.guesses_left = 3

        example_game.guesses_and_boats_left_message

        expect(@output.string).to include("3 guesses")
      end
    end

    context "when there is 1 guess left" do
      it "outputs 1 guess left" do
        input = StringIO.new
        @output = StringIO.new
        example_game = BattleshipsGame.new(input, @output)
        example_game.guesses_left = 1

        example_game.guesses_and_boats_left_message

        expect(@output.string).to include("1 guess")
      end
    end

    context "when there are 9 boats left" do
      it "outputs 9 boats left" do
        input = StringIO.new
        @output = StringIO.new
        example_game = BattleshipsGame.new(input, @output)

        example_game.guesses_and_boats_left_message

        expect(@output.string).to include("9 boats")
      end
    end

    context "when there is 1 boat left" do
      it "outputs 1 boat left" do
        input = StringIO.new
        @output = StringIO.new
        example_game = BattleshipsGame.new(input, @output)
        example_game.game_boat_list = BoatList.new([@boat_1 = Boat.new([[1,1]])])

        example_game.guesses_and_boats_left_message

        expect(@output.string).to include("1 boat")
      end
    end
  end

  describe "#take_and_convert_user_input" do
    context "when first input is correct" do
      it "sets target_grid_point" do
        input = StringIO.new("A1")
        example_game = BattleshipsGame.new(input)

        example_game.take_and_convert_user_input

        expect(example_game.target_grid_point).to eql([1,1])
      end
    end

    context "when first input is incorrect" do
      it "sets target_grid_point to second input" do
        input = StringIO.new("123\nA1")
        example_game = BattleshipsGame.new(input)

        example_game.take_and_convert_user_input

        expect(example_game.target_grid_point).to eql([1,1])
      end
    end
  end

  describe "#take_input_until_correct" do
    context "when first input is correct" do
      it "returns input" do
        input = StringIO.new("A1")
        example_game = BattleshipsGame.new(input)

        expect(example_game.take_input_until_correct).to eql("A1")
      end
    end

    context "when first input is incorrect" do
      it "returns second input" do
        input = StringIO.new("123\nA1")
        example_game = BattleshipsGame.new(input)

        expect(example_game.take_input_until_correct).to eql("A1")
      end
    end
  end

  describe "#input_is_valid?" do
    context "when input is valid" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_valid?("A1")).to be true
      end
    end

    context "when input is invalid as not in correct format" do
      it "returns false and outputs 'you entered something silly!'" do
        input = StringIO.new
        @output = StringIO.new
        example_game = BattleshipsGame.new(input, @output)

        expect(example_game.input_is_valid?("Z1")).to be_falsey
        expect(@output.string).to include("something silly")
      end
    end

    context "when input is invalid as it has been entered previously" do
      it "returns false and outputs 'already tried that one!'" do
        input = StringIO.new
        @output = StringIO.new
        example_game = BattleshipsGame.new(input, @output)

        example_game.game_grid.record_hit([1,1])

        expect(example_game.input_is_valid?("A1")).to be_falsey
        expect(@output.string).to include("already tried")
      end
    end
  end

  describe "#input_is_not_in_correct_format?" do
    context "when input is entered in the correct format" do
      it "returns false" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("a1")).to be false
      end
    end

    context "when input does not begin with a letter" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("91")).to be true
        expect(example_game.input_is_not_in_correct_format?("?7")).to be true
      end
    end

    context "when input begins with a letter outside of range" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("L3")).to be true
      end
    end

    context "when the second character of the input is not a number between 1 and 9" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("A0")).to be true
      end
    end

    context "when input is exactly 3 characters long and the second is not a 1" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("A20")).to be true
      end
    end

    context "when input is exactly 3 characters long and the third is not a 0" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("A11")).to be true
      end
    end

    context "when input is 4 characters or longer" do
      it "returns true" do
        example_game = BattleshipsGame.new

        expect(example_game.input_is_not_in_correct_format?("A101")).to be true
      end
    end
  end

  describe "#input_has_previously_been_entered?" do
    context "when input has not previously been entered" do
      it "returns false" do
        example_game = BattleshipsGame.new

        expect(example_game.input_has_previously_been_entered?("A1")).to eql(false)
      end
    end

    context "when input has previously been entered" do
      it "returns true" do
        example_game = BattleshipsGame.new

        example_game.game_grid.record_hit([1,1])

        expect(example_game.input_has_previously_been_entered?("A1")).to eql(true)
      end
    end
  end

  describe "#convert_input_to_grid_point" do
    it "returns a string as a corresponding grid point" do
      example_game = BattleshipsGame.new

      expect(example_game.convert_input_to_grid_point("A1")).to eql([1,1])
    end

    it "returns a string as a corresponding grid point where the row is '10'" do
      example_game = BattleshipsGame.new

      expect(example_game.convert_input_to_grid_point("A10")).to eql([10,1])
    end
  end
end
