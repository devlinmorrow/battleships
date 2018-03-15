class BoatTracker

  def self.any_boat_hit?(boat_list, targeted_coordinates)
    hit = false
    boat_list.each do |boat|
      if boat.any_coordinates_hit?(targeted_coordinates)
        hit = true
      end
    end
    hit
  end

  def self.which_boat_hit?(boat_list, targeted_coordinates)
    hit_boat = nil
    boat_list.each do |boat|
      if boat.any_coordinates_hit?(targeted_coordinates)
        hit_boat = boat
      end
    end
    hit_boat
  end

  def self.count_boats_not_sunk(boat_list)
    boat_list.length - boat_list.count {|boat| boat.sunk?}
  end

  def self.all_boats_sunk?(boat_list)
    boat_list.all? {|boat| boat.sunk?}
  end
end
