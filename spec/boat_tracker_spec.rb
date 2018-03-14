require 'boat_tracker'
require 'boat'

describe BoatTracker do
  describe ".any_boat_hit?" do
    context "when the user input hits the coordinates of a boat" do
      it "returns true" do
        example_boat = Boat.new([[1,1]])

        expect(BoatTracker.any_boat_hit?([example_boat],[1,1])).to eql(true)
      end
    end

    context "when the user input does not hit any boat's coordinates" do
      it "returns false" do
        example_boat = Boat.new([[1,1]])

        expect(BoatTracker.any_boat_hit?([example_boat],[2,1])).to eql(false)
      end
    end
  end

  describe ".which_boat_hit?" do
    context "when the user input hits the coordinates of a boat" do
      it "returns the boat object" do
        example_boat = Boat.new([[1,1]])
        example_boat_2 = Boat.new([[1,2]])

        expect(BoatTracker.which_boat_hit?([example_boat, example_boat_2],[1,1])).to eql(example_boat)
      end
    end
  end

  describe ".count_boats_not_sunk" do
    context "when there is one boat not sunk" do
      it "returns 1" do
        example_boat = Boat.new([[1,1]])

        expect(BoatTracker.count_boats_not_sunk([example_boat])).to eql(1)
      end
    end

    context "when there are two boats not sunk" do
      it "returns 2" do
        example_boat = Boat.new([[1,1]])
        example_boat_2 = Boat.new([[1,2]])

        expect(BoatTracker.count_boats_not_sunk([example_boat, example_boat_2])).to eql(2)
      end
    end
  end

  describe ".all_boats_sunk?" do
    context "when all boats have been sunk" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        example_boat.coords_hash[[9,1]] = true

        expect(BoatTracker.all_boats_sunk?([example_boat])).to eql(true)
      end
    end

    context "not all boats sunk" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(BoatTracker.all_boats_sunk?([example_boat])).to eql(false)
      end
    end
  end
end

