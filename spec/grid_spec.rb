require "grid"

describe "Grid" do
  describe "#construct_initial_grid" do
    context "when grid size is 10" do
      it "contains at least one target" do
        example_grid = Grid.new

        expect(example_grid.grid[1]).to include("║  ☺  ║") 
      end

      it "returns a value at the 11th element of the 2D array" do
        example_grid = Grid.new

        expect(example_grid.grid[10]).not_to be_nil
      end

      it "contains letters in the first row" do
        example_grid = Grid.new

        expect(example_grid.grid[0]).to include("A")
      end

      it "contains an integer in front of each row" do
        example_grid = Grid.new

        expect(example_grid.grid[1][0]).to include("1")
      end
    end
  end

  describe "#display_board" do
    it "outputs the current board" do
      input = StringIO.new
      @output = StringIO.new
      example_grid = Grid.new(input, @output)

      example_grid.display_board

      expect(@output.string).to include("║  ☺  ║")
    end
  end
end
