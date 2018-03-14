class Boat

  attr_reader :coords_hash

  def initialize(coords_array)
    @coords_hash = Hash.new
    coords_array.each do |coords|
      @coords_hash[coords] = false
    end
    #Add code to throw an error if the boat_coords parameter given is not an array of arrays?
  end

  def record_hit(target_coords)
    @coords_hash[target_coords] = true
  end

  def sunk?
    @coords_hash.values.all?
  end
end
