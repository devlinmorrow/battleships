require 'boat_list'
require 'boat'

describe BoatList do
  describe "#initialize" do
    it "creates a boat_class array of boat objects" do
      example_boat = Boat.new([[1,1]])
      example_boat_list = BoatList.new(example_boat)

      expect(example_boat_list[0]).to eql(example_boat)
    end
  end
end
