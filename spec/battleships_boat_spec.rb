require 'battleships_boat'

describe Boat do
  describe ".boat_coords_hit?" do
    context "when boat coords hit" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.boat_coords_hit?([example_boat],[9,1])).to eql(true)
      end

      it "sets coordinate value to 'true'" do
        example_boat = Boat.new([[9,1]])

        Boat.boat_coords_hit?([example_boat],[9,1])

        expect(example_boat.boat_coords_hash[[9,1]]).to eql(true)
      end
    end

    context "when boat coords not hit" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.boat_coords_hit?([example_boat],[1,1])).to eql(false)
      end

      it "maintains coordinate value as 'false'" do
        example_boat = Boat.new([[9,1]])

        Boat.boat_coords_hit?([example_boat],[1,1])

        expect(example_boat.boat_coords_hash[[9,1]]).to eql(false)
      end
    end
  end

  describe "#boat_sunk?" do
    context "all boat coords hit" do
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


end

