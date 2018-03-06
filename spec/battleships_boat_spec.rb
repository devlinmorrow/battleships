require 'battleships_boat'

describe Boat do
  describe "#initialize" do
    it "creates a hash with coordinates as keys and false as the default value" do
      example_boat = Boat.new([[9,1]])

      expect(example_boat.boat_coords_hash[[9,1]]).to eql(false)
    end
  end

  describe ".boat_coords_hit?" do
    context "when input hits a boat's coordinates" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.boat_coords_hit?([example_boat],[9,1])).to eql(true)
      end

      it "sets the value of such coordintes of the boat to 'true'" do
        example_boat = Boat.new([[9,1]])

        Boat.boat_coords_hit?([example_boat],[9,1])

        expect(example_boat.boat_coords_hash[[9,1]]).to eql(true)
      end
    end

    context "when input does not hit a boat's coordinates" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.boat_coords_hit?([example_boat],[1,1])).to eql(false)
      end
    end
  end

  describe "#boat_sunk?" do
    context "all of a boat's coordinates have been hit" do
      it "returns true" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.boat_coords_hash[[6,5]] = true
        example_boat.boat_coords_hash[[6,6]] = true

        expect(example_boat.boat_sunk?).to eql(true)
      end
    end

    context "not all boat coords hit" do
      it "returns false" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.boat_coords_hash[[6,6]] = true

        expect(example_boat.boat_sunk?).to eql(false)
      end
    end
  end

  describe ".any_boat_sunk?" do
    context "a boat sunk" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        example_boat.boat_coords_hash[[9,1]] = true

        expect(Boat.any_boat_sunk?([example_boat])).to eql(true)
      end
    end
  end

  describe ".all_boats_sunk?" do
    context "all boats sunk" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        example_boat.boat_coords_hash[[9,1]] = true

        expect(Boat.all_boats_sunk?([example_boat])).to eql(true)
      end
    end

    context "not all boats sunk" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.all_boats_sunk?([example_boat])).to eql(false)
      end
    end
  end

  describe ".count_boats_not_sunk" do
    it "returns 1" do
      example_boat = Boat.new([[9,1]])

      expect(Boat.count_boats_not_sunk([example_boat])).to eql(1)
    end
  end
end

