#!/usr/bin/env ruby

require_relative 'grid.rb'
require_relative 'boat.rb'

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
    make_guesses
    if game_is_won 
      win_message
    else
      lose_message
    end
  end

  def initial_message
    @output.puts "Welcome to Battleships! You have #{@guesses_left} guesses to sink #{@boat_list.length} boats.\nI will tell you when you have sunk a boat and you won't lose a guess if you hit a boat. Good luck!"
    @game_grid.display_board
  end

  def make_guesses
    while @guesses_left > 0 && !game_is_won
      guesses_and_boats_left_message
      take_user_input
      mark_as_hit_or_miss
      state_if_hit_or_miss
      state_if_any_boat_sunk
      @game_grid.display_board
      decrease_guesses_left_if_not_hit
    end
  end

  def game_is_won
    Boat.all_boats_sunk?(@boat_list)
  end

  def guesses_and_boats_left_message
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
    @output.puts "\nPlease pick the coordinates you wish to attack (in the format: letter-number)."
    input_validation
  end

  def input_validation
    @selected_box_coordinates = @input.gets.chomp.to_s
    if !is_input_in_correct_format?(@selected_box_coordinates)
      @output.puts "\nOops, looks like you entered something silly!"
      take_user_input
    elsif has_input_previously_been_entered?(convert_coordinates)
      @output.puts "\nOops, looks like you've already tried that one!"
      take_user_input
    end
  end

  def is_input_in_correct_format?(input)
    input = input.chars
    if !LETTERCOLLECTION[0..9].include?(input[0].upcase)
      return false
    elsif input[3]
      return false
    elsif input.length == 3 
      return false unless input[1].to_i == "1" && input[2] == "2"
    elsif !("1".."9").to_a.include?(input[1])
      return false
    end
    true
  end

  def has_input_previously_been_entered?(input)
    @game_grid.grid[input[0]][input[1]] != "║  ☺  ║"
  end

  def convert_coordinates
    #add input parameter to this instead of reading the instance variable selected box coords wherever it is.
    coordinates_array = @selected_box_coordinates.chars
    if coordinates_array[2] == "0"
      coordinates_array.pop
      coordinates_array[1] = "10"
    end
    column = LETTERCOLLECTION.index(coordinates_array[0].upcase) + 1 
    row = coordinates_array[1].to_i
    [row, column]
  end

  def mark_as_hit_or_miss
    if hit?
      @game_grid.grid[convert_coordinates[0]][convert_coordinates[1]] = "║  ⚓  ║"
    else
      @game_grid.grid[convert_coordinates[0]][convert_coordinates[1]] = "║  ☠  ║"
    end
  end

  def hit?
    Boat.boat_coords_hit?(@boat_list, convert_coordinates)
  end

  def state_if_hit_or_miss
    if hit?
    @output.puts "You got one!"
    else
      @output.puts "Ah... Looks like you missed."
    end
  end

  def state_if_any_boat_sunk
    if Boat.any_boat_sunk?(@boat_list)
      boat_sunk_message 
    end
  end

  def boat_sunk_message
    @output.puts "Yay! You sank a boat!"
  end

  def decrease_guesses_left_if_not_hit
    if !hit?
      @guesses_left -= 1
    end
  end

  def win_message
    @output.puts "Yay! You won!"
  end

  def lose_message
    @output.puts "Oh dear. Looks like you lost!"
  end
end

@b = Battleships.new
