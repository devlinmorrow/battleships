require 'boat'

describe Boat do
  describe "#initialize" do
    it "initialises boat objects with false values to represent 'not yet hit'" do
      example_boat = Boat.new([[9,1]])

      expect(example_boat.set_of_coordinates.values).to eql([false])
    end
  end

  describe "#check_if_hit" do
    context "when the input hits one of the boat's coordinates" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])

        expect(example_boat.any_coordinates_hit?([9,1])).to eql(true)
      end
    end

    context "when the input does not match any of the boat's coordinates" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])

        expect(example_boat.any_coordinates_hit?([1,1])).to eql(false)
      end
    end
  end

  describe "#record_hit" do
    it "sets value of that boat's corresponding coordinates to true" do
      example_boat = Boat.new([[9,1]])

      example_boat.record_hit([9,1])

      expect(example_boat.set_of_coordinates[[9,1]]).to eql(true)
    end
  end

  describe "#sunk?" do
    context "when all of a boat's coordinates have been hit" do
      it "returns true" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.set_of_coordinates[[6,5]] = true
        example_boat.set_of_coordinates[[6,6]] = true

        expect(example_boat.sunk?).to eql(true)
      end
    end

    context "not all boat coords hit" do
      it "returns false" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.set_of_coordinates[[6,6]] = true

        expect(example_boat.sunk?).to eql(false)
      end
    end
  end
end


