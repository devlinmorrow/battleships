class BoatTracker

  def self.any_boat_hit?(boat_list, target_coords)
    hit = false
    boat_list.each do |boat|
      boat.coords_hash.each_key do |boat_coords|
        if boat_coords == target_coords
          hit = true
        end
      end
    end
    hit
  end

  def self.which_boat_hit?(boat_list, target_coords)
    attacked_boat = nil
    boat_list.each do |boat|
      boat.coords_hash.each_key do |coords_key|
        if coords_key == target_coords
          attacked_boat = boat
        end
      end
    end
    attacked_boat
  end

  def self.count_boats_not_sunk(boat_list)
    boat_list.length - boat_list.count {|boat| boat.sunk?}
  end

  def self.all_boats_sunk?(boat_list)
    boat_list.all? {|boat| boat.sunk?}
  end
end
