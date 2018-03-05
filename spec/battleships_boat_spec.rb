require 'battleships_boat'

describe Boat do
  describe "#boat_coords_hit?" do
    context "when boat coords hit" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.boat_coords_hit?([example_boat],[9,1])).to eql(true)
      end
    end

    context "when boat coords not hit" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(Boat.boat_coords_hit?([example_boat],[1,1])).to eql(false)
      end
    end
  end

  describe "#boat_sunk?" do
    context "all boat coords hit" do
      xit "sets boat_1 boat_sunk condition to true" do
        example_boat = Boat.new([[9,1]])

        expect(example_boat.boat_sunk?).to eql(true)
      end
    end
  end

end
