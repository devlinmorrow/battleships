require 'game'

describe Battleships do
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

  describe "#input_is_in_correct_format?" do
    context "when input is entered in the correct format" do
      it "returns true" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("A1")).to be true
      end
    end

    context "when input does not begin with a letter" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("91")).to be false
        expect(example_game.input_is_in_correct_format?("?7")).to be false
      end
    end

    context "when input begins with a letter outside of range" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("L3")).to be false
      end
    end

    context "when the second character of the input is not a number between 1 and 9" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("A0")).to be false
      end
    end

    context "when input is exactly 3 characters long and the second is not a 1" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("A20")).to be false
      end
    end

    context "when input is exactly 3 characters long and the third is not a 0" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("A11")).to be false
      end
    end

    context "when input is 4 characters or longer" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_is_in_correct_format?("A101")).to be false
      end
    end
  end

  describe "#input_has_previously_been_entered?" do
    context "when input has not previously been entered" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.input_has_previously_been_entered?("A1")).to eql(false)
      end
    end

    context "when input has previously been entered" do
      it "returns true" do
        example_game = Battleships.new

        example_game.game_grid.record_hit([1,1])

        expect(example_game.input_has_previously_been_entered?("A1")).to eql(true)
      end
    end
  end

  describe "#convert_input_to_grid_point" do
    it "converts and stores the user input as an array of grid coordinates" do
      example_game = Battleships.new

      expect(example_game.convert_input_to_grid_point("A1")).to eql([1,1])
    end

    it "handles the case where the row selected is '10'" do
      example_game = Battleships.new

      expect(example_game.convert_input_to_grid_point("A10")).to eql([10,1])
    end
  end
end
