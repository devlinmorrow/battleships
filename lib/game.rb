#!/usr/bin/env ruby

require_relative 'grid.rb'
require_relative 'boat.rb'
require_relative 'boat_list.rb'

class Battleships

  attr_accessor :guesses_left
  attr_reader :game_grid, :targeted_grid_coordinates 

  LETTERCOLLECTION = ("A".."Z").to_a

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 20
    @game_grid = Grid.new
    @game_boat_list = BoatList.new(create_boat_list)
  end

  def create_boat_list
    [@boat_1 = Boat.new([[9,1]]),
     @boat_2 = Boat.new([[8,3]]),
     @boat_3 = Boat.new([[7,1]]),
     @boat_4 = Boat.new([[2,7]]),
     @boat_5 = Boat.new([[6,5],[6,6]]),
     @boat_6 = Boat.new([[6,2],[6,3]]),
     @boat_7 = Boat.new([[3,1],[4,1],[5,1]]),
     @boat_8 = Boat.new([[2,9],[3,9],[4,9]]),
     @boat_9 = Boat.new([[9,2],[9,3],[9,4],[9,5]])]
  end

  def play_game
    system "clear"
    initial_message
    make_guesses
    if game_is_won
      win_message
    else
      lose_message
    end
  end

  def initial_message
    @output.puts "Welcome to Battleships! You have #{@guesses_left} guesses to sink #{@game_boat_list.count_boats_not_sunk} boats.\nI will tell you when you have sunk a boat and you won't lose a guess if you hit a boat. Good luck!"
    sleep(5)
    system "clear"
  end

  def make_guesses
    while @guesses_left > 0 && !game_is_won
      @game_grid.display_board
      sleep(1)
      guesses_and_boats_left_message
      take_and_convert_user_input
      if @game_boat_list.any_boat_hit?(@targeted_grid_coordinates)
        run_hit_mechanics
      else
        run_miss_mechanics
      end
    end
  end

  def game_is_won
    @game_boat_list.all_boats_sunk?
  end

  def guesses_and_boats_left_message
    @output.print "You have "
    if @guesses_left == 1 
      @output.print "1 guess"
    else
      @output.print "#{guesses_left} guesses"
      @output.print " left to sink"
    end
    if @game_boat_list.count_boats_not_sunk == 1 
      @output.print " 1 boat."
    else
      @output.print " #{@game_boat_list.count_boats_not_sunk} boats."
    end
    sleep(1)
  end

  def take_and_convert_user_input
    input = take_user_input
    @targeted_grid_coordinates = convert_input_to_coordinates(input)
    system "clear"
  end

  def take_user_input
    @output.puts "\nplease pick the coordinates you wish to attack (in the format: letter-number)."
    input_validation
  end

  def input_validation
    user_input = @input.gets.chomp.to_s
    if !is_input_in_correct_format?(user_input)
      @output.puts "\nOops, looks like you entered something silly!"
      take_user_input
    elsif has_input_previously_been_entered?(user_input)
      @output.puts "\nOops, looks like you've already tried that one!"
      take_user_input
    end
    user_input
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
    grid_coords = convert_input_to_coordinates(input)
    @game_grid.grid[grid_coords[0]][grid_coords[1]] != "║  ☺  ║"
  end

  def convert_input_to_coordinates(input)
    input = input.chars
    if input[2] == "0"
      input.pop
      input[1] = "10"
    end
    column = LETTERCOLLECTION.index(input[0].upcase) + 1 
    row = input[1].to_i
    [row, column]
  end

  def run_hit_mechanics
    hit_message
    @game_grid.record_hit(@targeted_grid_coordinates)
    boat_hit = @game_boat_list.which_boat_hit?(@targeted_grid_coordinates)
    boat_hit.record_hit(@targeted_grid_coordinates)
    if boat_hit.sunk?
      boat_sunk_message
    end
  end

  def hit_message
    @output.puts "You hit one! You don't lose a guess."
  end

  def boat_sunk_message
    @output.puts "Yay! You sank a boat!"
  end

  def run_miss_mechanics
    miss_message
    @game_grid.record_miss(@targeted_grid_coordinates)
    @guesses_left -= 1
  end

  def miss_message
    @output.puts "Ah... Looks like you missed. You lose a guess."
  end

  def win_message
    @output.puts "Yay! You won!"
  end

  def lose_message
    @output.puts "Oh dear. Looks like you lost!"
  end
end

@b = Battleships.new
