#!/usr/bin/env ruby

require_relative 'battleships_grid.rb'
require_relative 'battleships_boat.rb'

class Battleships

  attr_accessor :guesses_left, :boat_list
  attr_reader :game_grid, :selected_box_coordinates, :boat_1

  LETTERCOLLECTION = ("A".."Z").to_a

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 150
    @game_grid = Grid.new
    @boat_list = create_boat_list
  end

  def create_boat_list
    @boat_1 = Boat.new([[9,1]])
    @boat_2 = Boat.new([[8,3]])
    @boat_3 = Boat.new([[7,1]])
    @boat_4 = Boat.new([[2,7]])
    @boat_5 = Boat.new([[6,5],[6,6]])
    @boat_6 = Boat.new([[6,2],[6,3]])
    @boat_7 = Boat.new([[3,1],[4,1],[5,1]])
    @boat_8 = Boat.new([[2,9],[3,9],[4,9]])
    @boat_9 = Boat.new([[9,2],[9,3],[9,4],[9,5]])
    [@boat_1, @boat_2, @boat_3, @boat_4, @boat_5, @boat_6, @boat_7, @boat_8, @boat_9]
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
    @output.puts "Welcome to Battleships! You have #{@guesses_left} guesses to hit #{@boat_list.length} boats. If you hit a boat, you won't lose a guess and I will also tell you when you have sunk a boat... Good luck!"
    @game_grid.display_board
  end

  def run_guess
    while @guesses_left > 0 && !game_is_won
      guesses_left_message
      take_user_input
      mark_as_hit_or_miss
      @game_grid.display_board
      @guesses_left -= 1
    end
  end

  def game_is_won
    Boat.all_boats_sunk?(@boat_list)
  end

  def guesses_left_message
    @output.print "You have "
    if @guesses_left == 1 
      @output.print "1 guess"
    else
      @output.print "#{guesses_left} guesses"
      @output.print " left to sink"
    end
    if Boat.count_boats_not_sunk(@boat_list) == 1 
      @output.print " 1 boat."
    else
      @output.print " #{Boat.count_boats_not_sunk(@boat_list)} boats."
    end
  end

def take_user_input
  @output.puts "Please pick the coordinates you wish to attack"
  @selected_box_coordinates = @input.gets.chomp.to_s
end

def mark_as_hit_or_miss
  target_coords = convert_coordinates
  if Boat.boat_coords_hit?(@boat_list, target_coords)
    @game_grid.grid[target_coords[0]][target_coords[1]] = "║  ⚓  ║"
  else
    @game_grid.grid[target_coords[0]][target_coords[1]] = "║  ☠  ║"
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
