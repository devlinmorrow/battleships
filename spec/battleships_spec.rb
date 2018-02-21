require 'battleships'

describe Battleships do
  describe "set up  board" do
    it "should start with a box" do
      example_game = Battleships.new

      expect(example_game.grid[1]).to include("║  ☺  ║") 
    end
    it "should display the grid" do
      input = StringIO.new
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.display_board

      expect(@output.string).to include("║  ☺  ║")
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
  it "should mark A1 as attacked but missed" do
    input = StringIO.new("A1")
    example_game = Battleships.new(input)

    example_game.take_user_input
    example_game.mark_as_hit_or_miss

    expect(example_game.grid[1][1]).to eql("║  ☠  ║")
  end
  it "should mark B6 as attacked and hit" do
    input = StringIO.new("B6")
    example_game = Battleships.new(input)

    example_game.take_user_input
    example_game.mark_as_hit_or_miss

    expect(example_game.grid[6][2]).to eql("║  ⚓  ║")
  end
  describe "guess mechanic" do
    it "should start with 20 guesses left" do
      example_game = Battleships.new

      expect(example_game.guesses_left).to eq(20)
    end
    it "should minus one guess after guess made" do
      input = StringIO.new("A1")
      example_game = Battleships.new(input)

      example_game.run_guess

      expect(example_game.guesses_left).to eq(19)
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
      input = StringIO.new("B6\nB7\nC10\nJ4\nB2\nC3\nA8\nH8\nI7")
      @output = StringIO.new
      example_game = Battleships.new(input, @output)

      example_game.play_game

      expect(example_game.game_is_won).to be(true)
      expect(@output.string).to include("won")
    end
  end
end
