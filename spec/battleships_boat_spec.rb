require 'battleships_boat'

describe Boat do
  describe "#return_coordinates_array" do
    it "returns array coordinates of boat" do
      example_boat = Boat.new([[9,1]])

      expect(example_boat.return_coordinates).to eql([[9,1]])
    end
  end

end
