class Boat

  attr_reader :set_of_coordinates

  def initialize(coordinates_data)
    @set_of_coordinates = Hash.new
    coordinates_data.each do |each_coordinates_target|
      @set_of_coordinates[each_coordinates_target] = false
    end
  end

  def any_coordinates_hit?(targeted_coordinates)
    hit = false
    @set_of_coordinates.each_key do |each_set_of_coords_of_boat|
      if each_set_of_coords_of_boat == targeted_coordinates
        hit = true
      end
    end
    hit
  end

  def record_hit(targeted_coordinates)
    @set_of_coordinates[targeted_coordinates] = true
  end

  def sunk?
    @set_of_coordinates.values.all?
  end
end
