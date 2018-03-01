require_relative 'battleships_grid.rb'

class Battleships

  attr_accessor :guesses_left, :boat_list
  attr_reader :game_is_won, :game_grid, :selected_box_coordinates

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 20
    @game_is_won = false
    @letter_collection = ("A".."Z").to_a
    @game_grid = Grid.new
    @boat_list = {
      boat_1: [false, [9,1]],
      boat_2: [false, [8,3]],
      boat_3: [false, [7,1]],
      boat_4: [false, [2,7]],
      boat_5: [false, [6,5],[6,6]],
      boat_6: [false, [6,2],[6,3]],
      boat_7: [false, [3,1],[4,1],[5,1]],
      boat_8: [false, [2,9],[3,9],[4,9]],
      boat_9: [false, [9,2],[9,3],[9,4],[9,5]]
    }
  end

  def play_game
    @output.puts "Welcome to Battleships! You have 20 guesses to hit 9 boats"
    @game_grid.display_board
    while @guesses_left > 0 && !@game_is_won
      take_user_input
      mark_as_hit_or_miss
      @game_grid.display_board
      @guesses_left -= 1
      check_if_game_is_won
    end
    if @game_is_won 
      @output.puts "Yay! You won!"
    elsif !@game_is_won
      @output.puts "Oh dear. Looks like you lost!"
    end
  end

  def take_user_input
    @output.puts "Please pick the coordinates you wish to attack"
    @selected_box_coordinates = @input.gets.chomp.to_s
  end

  def convert_coordinates
    coordinates_array = @selected_box_coordinates.chars
    #If user has selected 10, it will be split into separate chars, so amend this then relate the user input to the grid coordinates.
    if coordinates_array[2] == "0"
      coordinates_array.pop
      coordinates_array[1] = "10"
    end
    column = @letter_collection.index(coordinates_array[0].upcase) + 1
    row = coordinates_array[1].to_i
    [row, column]
  end

  def check_if_hit_or_miss
    var = convert_coordinates
    #Take the attacked coordinates in form [row, column] and ask check each value in the hash (which are 2D arrays) whether they include such coordinates. If they do, set the variable to the corresponding hash key, otherwise leave it as the coordinates. Return the variable.
    @boat_list.each_value do |value|
      if value.drop(1).include?(var)
        var = @boat_list.key(value)
      end
    end
    var 
  end

  def mark_as_hit_or_miss
    var = check_if_hit_or_miss
    #Take the variable from the check. If it's a hash key, i.e. corresponds to one of the boats, use the boat's coordinates to mark where the hit is on the game_grid object. If it's not a hash key, the coordinates were a miss so mark this on the game_grid object.
    if var.is_a?(Symbol)
      arr = @boat_list[var]
      arr[0] = true
      @boat_list[var].drop(1).each do |boat_coords|
        @game_grid.grid[boat_coords[0]][boat_coords[1]] = "║  ⚓  ║"
      end
    else
      @game_grid.grid[var[0]][var[1]] = "║  ☠  ║"
    end
  end

  def check_if_game_is_won
    #Set game is won condition to true if the first element of all boat arrays have been set to 'true', i.e. there are no 'false's present in boat_list.
    @game_is_won = true if !@boat_list.values.flatten.any?(false)
  end

end

@b = Battleships.new
