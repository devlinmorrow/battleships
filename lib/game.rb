#!/usr/bin/env ruby

require_relative 'grid.rb'
require_relative 'boat.rb'
require_relative 'boat_list.rb'

class Battleships

  attr_accessor :guesses_left
  attr_reader :user_input, :converted_coordinates, :game_boat_list_tracker

  LETTERCOLLECTION = ("A".."Z").to_a

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 20
    @game_grid = Grid.new
    @game_game_boat_list_tracker_tracker = BoatListTracker.new(create_boat_list)
  end

  def create_boat_list
    @boat_1 = boat.new([[9,1]])
    @boat_2 = boat.new([[8,3]])
    @boat_3 = boat.new([[7,1]])
    @boat_4 = boat.new([[2,7]])
    @boat_5 = boat.new([[6,5],[6,6]])
    @boat_6 = boat.new([[6,2],[6,3]])
    @boat_7 = boat.new([[3,1],[4,1],[5,1]])
    @boat_8 = boat.new([[2,9],[3,9],[4,9]])
    @boat_9 = boat.new([[9,2],[9,3],[9,4],[9,5]])
    [@boat_1, @boat_2, @boat_3, @boat_4, @boat_5, @boat_6, @boat_7, @boat_8, @boat_9]
  end

  def play_game
    system "clear"
    initial_message
    make_guesses
    if game_is_won(@game_boat_list_tracker)
      win_message
    else
      lose_message
    end
  end

  def initial_message
    @output.puts "Welcome to Battleships! You have #{@guesses_left} guesses to sink #{@game_boat_list_tracker.length} boats.\nI will tell you when you have sunk a boat and you won't lose a guess if you hit a boat. Good luck!"
    sleep(5)
    system "clear"
  end

  def make_guesses
    while @guesses_left > 0 && !game_is_won(@game_boat_list_tracker)
      @game_grid.display_board
      sleep(1)
      guesses_and_boats_left_message
      take_user_input
      convert_coordinates(@user_input)
      if BoatTracker.any_boat_hit?(@game_boat_list_tracker, @converted_coordinates)
        run_hit_mechanics
      else
        run_miss_mechanics
      end
    end
  end

  def game_is_won(game_boat_list_tracker)
    BoatTracker.all_boats_sunk?(game_boat_list_tracker)
  end

  def guesses_and_boats_left_message
    @output.print "You have "
    if @guesses_left == 1 
      @output.print "1 guess"
    else
      @output.print "#{guesses_left} guesses"
      @output.print " left to sink"
    end
    if BoatTracker.count_boats_not_sunk(@game_boat_list_tracker) == 1 
      @output.print " 1 boat."
    else
      @output.print " #{BoatTracker.count_boats_not_sunk(@game_boat_list_tracker)} boats."
    end
    sleep(1)
  end

  def take_user_input
    @output.puts "\nPlease pick the coordinates you wish to attack."
    @user_input = @input.gets.chomp.to_s
    system "clear"
  end

  def convert_coordinates(input)
    coordinates_array = input.chars
    if coordinates_array[2] == "0"
      coordinates_array.pop
      coordinates_array[1] = "10"
    end
    column = LETTERCOLLECTION.index(coordinates_array[0].upcase) + 1 
    row = coordinates_array[1].to_i
    @converted_coordinates = [row, column]
  end

  def run_hit_mechanics
    hit_message
    @game_grid.record_hit(@converted_coordinates)
    boat_hit = BoatTracker.which_boat_hit?(@game_boat_list_tracker, @converted_coordinates)
    boat_hit.record_hit(@converted_coordinates)
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
    @game_grid.record_miss(@converted_coordinates)
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
