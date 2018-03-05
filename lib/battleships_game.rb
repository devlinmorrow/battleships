#!/usr/bin/env ruby

require_relative 'battleships_grid.rb'
require_relative 'battleships_boat.rb'

class Battleships

  attr_accessor :guesses_left, :boat_list
  attr_reader :game_grid, :selected_box_coordinates

  LETTERCOLLECTION = ("A".."Z").to_a

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 15
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
    initial_message
    run_guess
    if game_is_won 
      win_message
    else
      lose_message
    end
  end

  def initial_message
    @output.puts "Welcome to Battleships! You have 15 guesses to hit 9 boats"
    @game_grid.display_board
  end

  def run_guess
    while @guesses_left > 0 && !game_is_won
      take_user_input
      mark_as_hit_or_miss
      mark_if_boat_sunk
      @game_grid.display_board
      @guesses_left -= 1
    end
  end

  def game_is_won
    !@boat_list.values.flatten.any?(false)
  end

  def take_user_input
    @output.puts "Please pick the coordinates you wish to attack"
    @selected_box_coordinates = @input.gets.chomp.to_s
  end

  def mark_as_hit_or_miss
    target_coords = convert_coordinates
    boat_key = nil
    @boat_list.each_value do |value|
      boat_key = @boat_list.key(value) if value.drop(1).include?(target_coords)
    end
    if boat_key 
      @game_grid.grid[target_coords[0]][target_coords[1]] = "║  ⚓  ║"
    else
      @game_grid.grid[target_coords[0]][target_coords[1]] = "║  ☠  ║"
    end
    boat_key
  end

  def mark_if_boat_sunk
    #Trying to make a method which checks each element of any boat hit. If all coordinates of the boat have been hit, the true/false first element of the boat should be set to 'true' to mark that the boat is sunk.
    boat_key = mark_as_hit_or_miss
    x = false
    if boat_key
      i = 0
      boat_array = @boat_list[boat_key].drop(1)
      while x = true && i < array.length
        if @game_grid.grid[array[i][0]][array[i][1]] == "║  ⚓  ║"
          x = true
        else
          x = false
        end
      end
    end
    if x
      @boat_list[boat_key][0] = true
    end
  end

  def convert_coordinates
    coordinates_array = @selected_box_coordinates.chars
    if coordinates_array[2] == "0"
      coordinates_array.pop
      coordinates_array[1] = "10"
    end
    column = LETTERCOLLECTION.index(coordinates_array[0].upcase) + 1 
    row = coordinates_array[1].to_i
    [row, column]
  end

  def win_message
    @output.puts "Yay! You won!"
  end

  def lose_message
    @output.puts "Oh dear. Looks like you lost!"
  end
end

@b = Battleships.new
