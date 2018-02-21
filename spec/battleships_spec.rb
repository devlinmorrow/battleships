require 'battleships'

describe Battleships do
  describe "set up  board" do
    it "should start with a box" do
      example_game = Battleships.new

      expect(example_game.grid).to include("☺")
    end
    it "should display the grid" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.display_board

      expect(@output.string).to include("☺")
    end
  end
  describe "user selects box" do
    it "should allow user to pick a number" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.take_user_input

      expect(example_game.selected_box_coordinates).to eql("A1")
    end
  end
  it "should mark box 1 as attacked but missed" do
    input = StringIO.new("A1")
    example_game = Battleships.new(input)

    example_game.take_user_input
    example_game.mark_as_hit_or_miss

    expect(example_game.box_1_variable).to eql("☠")
  end
  it "should mark box 2 as attacked and hit" do
    input = StringIO.new("B1")
    example_game = Battleships.new(input)

    example_game.take_user_input
    example_game.mark_as_hit_or_miss

    expect(example_game.box_2_variable).to eql("⚓")
  end
  describe "guess mechanic" do
    it "should start with 6 guesses left" do
      example_game = Battleships.new

      expect(example_game.guesses_left).to eq(6)
    end
    it "should minus one guess after guess made" do
      input = StringIO.new("C1")
      example_game = Battleships.new(input)

      example_game.run_guess

      expect(example_game.guesses_left).to eq(5)
    end
  end
  describe "play the game, winning or losing" do
    it "should end if you run out of guesses" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)
      example_game.guesses_left = 0

      example_game.play_game

      expect(@output.string).to include("lost")
    end
  end
  describe "you win" do
    it "should set game won condition if all boats hit" do
      input = StringIO.new("B1\nC3")
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.play_game

      expect(example_game.game_is_won).to be(true)
      expect(@output.string).to include("won")
    end
  end
end
