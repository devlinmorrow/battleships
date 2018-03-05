class Boat

  attr_reader :boat_coords_hash

  def initialize(boat_coords_array)
    @boat_coords_hash = Hash.new
    boat_coords_array.each do |coords|
      @boat_coords_hash[coords] = false
    end
    #Add code to throw an error if the boat_coords parameter given is not an array of arrays?
  end

  def self.boat_coords_hit?(boat_list, target_coords)
    hit = false
    boat_list.each do |boat|
      boat.boat_coords_hash.each_key do |boat_coords|
        if boat_coords == target_coords
          boat.boat_coords_hash[boat_coords] = true
          hit = true
        end
      end
    end
    hit 
  end

  def boat_sunk?
    if boat_coords_hash.values.all?(true)
      true
    else
      false
    end
  end

  def self.all_boats_sunk?(boat_list)
    boat_list.all? {|boat| boat.boat_sunk? == true}
  end
end
