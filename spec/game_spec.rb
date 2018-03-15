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

  describe "#take_user_input" do
    it "stores user input" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.take_user_input

      expect(example_game.user_input).to eql("A1")
    end
  end

  describe "#is_input_in_correct_format?" do
    context "when input is in correct format" do
      it "returns true" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("A1")).to eql(true)
      end
    end

    context "when input does not begin with a letter" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("91")).to eql(false)
        expect(example_game.is_input_in_correct_format?("?7")).to eql(false)
      end
    end

    context "when input begins with a letter outside of range" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("L3")).to eql(false)
      end
    end

    context "when input is 4 characters or longer" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("A101")).to eql(false)
      end
    end

    context "when input is exactly 3 characters long and the second is not a 1" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("A20")).to eql(false)
      end
    end

    context "when input is exactly 3 characters long and the third is not a 0" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("A11")).to eql(false)
      end
    end

    context "when the second character of input is not a number from 1 to 9 inclusive" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.is_input_in_correct_format?("AB")).to eql(false)
      end
    end
  end

  describe "#has_input_previously_been_entered?" do
    context "when input has not previously been entered" do
      it "returns false" do
        example_game = Battleships.new

        expect(example_game.has_input_previously_been_entered?([1,1])).to eql(false)
      end
    end

    context "when input has previously been entered" do
      it "returns true" do
        example_game = Battleships.new

        example_game.game_grid.record_hit([1,1])

        expect(example_game.has_input_previously_been_entered?([1,1])).to eql(true)
      end
    end
  end

  describe "#convert_coordinates" do
    it "converts and stores the user input as an array of grid coordinates" do
      example_game = Battleships.new

      example_game.convert_coordinates("A1")

      expect(example_game.converted_coordinates).to eql([1,1])
    end

    it "handles the case where the row selected is '10'" do
      example_game = Battleships.new

      example_game.convert_coordinates("A10")

      expect(example_game.converted_coordinates).to eql([10,1])
    end
  end
end
