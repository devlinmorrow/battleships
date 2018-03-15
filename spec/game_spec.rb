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
