class BoatList

  def initialize(boat_list)
    @boat_list = boat_list
  end

  def any_boat_hit?(targeted_coordinates)
    hit = false
    @boat_list.each do |boat|
      if boat.any_coordinates_hit?(targeted_coordinates)
        hit = true
      end
    end
    hit
  end

  def which_boat_hit?(targeted_coordinates)
    hit_boat = nil
    @boat_list.each do |boat|
      if boat.any_coordinates_hit?(targeted_coordinates)
        hit_boat = boat
      end
    end
    hit_boat
  end

  def count_boats_not_sunk
    @boat_list.length - @boat_list.count {|boat| boat.sunk?}
  end

  def all_boats_sunk?
    @boat_list.all? {|boat| boat.sunk?}
  end
end
