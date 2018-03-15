require 'boat_list'
require 'boat'

describe BoatList do
  describe "#any_boat_hit?" do
    context "when the user input hits the coordinates of a boat" do
      it "returns true" do
        example_boat = Boat.new([[1,1]])
        example_boat_list = BoatList.new(example_boat)

        expect(example_boat_list.any_boat_hit?([1,1])).to eql(true)
      end
    end

    context "when the user input does not hit any boat's coordinates" do
      it "returns false" do
        example_boat = Boat.new([[1,1]])
        example_boat_list = BoatList.new(example_boat)

        expect(example_boat_list.any_boat_hit?([2,1])).to eql(false)
      end
    end
  end

  describe "#which_boat_hit?" do
    context "when the user input hits the coordinates of a boat" do
      it "returns the boat object" do
        example_boat = Boat.new([[1,1]])
        example_boat_2 = Boat.new([[1,2]])
        example_boat_list = BoatList.new([example_boat, example_boat_2])

        expect(example_boat_list.which_boat_hit?([example_boat, example_boat_2],[1,1])).to eql(example_boat)
      end
    end
  end

  describe "#count_boats_not_sunk" do
    context "when there is one boat not sunk" do
      it "returns 1" do
        example_boat = Boat.new([[1,1]])
        example_boat_list = BoatList.new(example_boat)

        expect(example_boat_list.count_boats_not_sunk).to eql(1)
      end
    end

    context "when there are two boats not sunk" do
      it "returns 2" do
        example_boat = Boat.new([[1,1]])
        example_boat_2 = Boat.new([[1,2]])
        example_boat_list = boatlist.new([example_boat, example_boat_2])

        expect(example_boat_list.count_boats_not_sunk).to eql(2)
      end
    end
  end

  describe "#all_boats_sunk?" do
    context "when all boats have been sunk" do
      it "returns true" do
        example_boat = Boat.new([[9,1]])
        example_boat_list = BoatList.new(example_boat)

        example_boat.set_of_coordinates[[9,1]] = true

        expect(example_boat_list.all_boats_sunk?).to eql(true)
      end
    end

    context "not all boats sunk" do
      it "returns false" do
        example_boat = Boat.new([[9,1]])
        example_boat_list = BoatList.new(example_boat)

        expect(example_boat_list.all_boats_sunk?).to eql(false)
      end
    end
  end
end

