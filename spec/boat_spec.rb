require 'boat'

describe Boat do
  describe "#any_point_matched?" do
    context "when the target grid point matches one of the boat's grid points" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        expect(example_boat.any_point_matched?([9,1])).to eql(true)
      end
    end

    context "when the target grid point does not match any of the boat's grid points" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(example_boat.any_point_matched?([1,1])).to eql(false)
      end
    end
  end

  describe "#record_hit" do
    it "records a 'hit' on the corresponding grid point of the boat by setting its value to 'true'" do
      example_boat = Boat.new([[9,1]])

      expect(example_boat.record_hit([9,1])).to eql(true)
    end
  end

  describe "#sunk?" do
    context "when all of a boat's grid points have been hit" do
      it "returns true" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.record_hit([6,5])
        example_boat.record_hit([6,6])

        expect(example_boat.sunk?).to eql(true)
      end
    end

    context "when not all of a boat's grid points have been hit" do
      it "returns false" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.record_hit([6,6])

        expect(example_boat.sunk?).to eql(false)
      end
    end
  end
end


