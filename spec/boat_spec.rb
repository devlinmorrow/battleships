require 'boat'

describe Boat do
  describe "#initialize" do
    it "creates a hash with coordinates as keys and false as the default value" do
      example_boat = Boat.new([[9,1]])

      expect(example_boat.coords_hash[[9,1]]).to eql(false)
    end
  end

  describe "#record_hit" do
    it "sets value of coordinates to true" do
      example_boat = Boat.new([[9,1]])

      example_boat.record_hit([9,1])

      expect(example_boat.coords_hash[[9,1]]).to eql(true)
    end
  end

  describe "#sunk?" do
    context "when all of a boat's coordinates have been hit" do
      it "returns true" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.coords_hash[[6,5]] = true
        example_boat.coords_hash[[6,6]] = true

        expect(example_boat.sunk?).to eql(true)
      end
    end

    context "not all boat coords hit" do
      it "returns false" do
        example_boat = Boat.new([[6,5],[6,6]])

        example_boat.coords_hash[[6,6]] = true

        expect(example_boat.sunk?).to eql(false)
      end
    end
  end
end


