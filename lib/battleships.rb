require_relative 'battleships_grid_module.rb'

class Battleships

  include GridCreatability

  attr_accessor :guesses_left, :selected_box_coordinates
  attr_reader :game_is_won, :grid

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 20
    @game_is_won = false
    @letter_collection = ("A".."Z").to_a
    @grid_size = 10
    construct_initial_grid
    set_random_boats
  end

  def play_game
    @output.puts "Welcome to Battleships! You have 20 guesses to hit 9 boats"
    display_board
    while @guesses_left > 0 && !@game_is_won
      run_guess
      check_if_all_boats_hit
    end
    if @game_is_won 
      @output.puts "Yay! You won!"
    elsif !@game_is_won
      @output.puts "Oh dear. Looks like you lost!"
    end
  end

  def run_guess
    take_user_input
    mark_as_hit_or_miss
    display_board
    @guesses_left -= 1
  end

  def take_user_input
    @output.puts "Please pick the coordinates you wish to attack"
    @selected_box_coordinates = @input.gets.chomp.to_s
  end

  def set_random_boats
    @boat_1 = generate_boat(1)
    p @boat_1[0]
    @boat_2 = generate_boat(1)
    p @boat_2[0]
    @boat_3 = generate_boat(1)
    p @boat_3[0]
    @boat_4 = generate_boat(1)
    p @boat_4[0]
    @boat_5 = generate_boat(2)
    p @boat_5[0]
    p @boat_5[1]
   @boat_6 = generate_boat(2)
   p @boat_6[0]
   p @boat_6[1]
   # @boat_7 = generate_boat(3)
   # p @boat_7[0]
   # p @boat_7[1]
   # p @boat_7[2]
   # @boat_8 = generate_boat(3)
   # p @boat_8[0]
   # p @boat_8[1]
   # p @boat_8[2]
   # @boat_9 = generate_boat(4)
   # p @boat_9[0]
   # p @boat_9[1]
   # p @boat_9[2]
   # p @boat_9[3]
  end

  def generate_boat(length)
    boat_array = []
    #Create the first coordinate of the boat, ensuring that the boat cannot extend further than the edges of the grid.
    length.times do
      r1 = rand(1..(@grid_size - length + 1))
      c1 = rand(1..(@grid_size - length + 1))
      boat_array << [r1,c1]
    end
    #Enlarge the boat to full size vertically or horizontally. 
    v_or_h = 1
    val = 1
    while val < length 
      boat_array[val][v_or_h] = boat_array[val][v_or_h] + val
      val += 1
    end
    boat_array
  end

  #length = 2
  #boat_array[1][0/1] = boat_array[1][0/1] + 1
  #
  #length = 3
  #boat_array[1][0/1] = boat_array[1][0/1] + 1
  #boat_array[2][0/1] = boat_array[2][0/1] + 2
  #
  #length = 4
  #boat_array[1][0/1] = boat_array[1][0/1] + 1
  #boat_array[2][0/1] = boat_array[2][0/1] + 2
  #boat_array[3][0/1] = boat_array[3][0/1] + 3
  #

  #def ensure_no_boat_the_same(boat1,boat2)
  #  (boat1 & boat2).empty?
  #end

  def convert_coordinates
    coordinates_array = @selected_box_coordinates.chars
    #If user has selected 10, it will be split into separate chars, so amend this then relate the user input to the grid coordinates.
    if coordinates_array[2] == "0"
      coordinates_array.pop
      coordinates_array[1] = "10"
    end
    column = @letter_collection.index(coordinates_array[0].upcase) + 1
    row = coordinates_array[1].to_i
    [row,column]
  end

  def check_if_match
    coords = convert_coordinates
    if @boat_1.include?(coords)
      "b1"
    elsif @boat_2.include?(coords)
      "b2"
    else
      @grid[coords[0]][coords[1]] = "║  ☠  ║"
    end
  end

  def mark_as_hit_or_miss
    case check_if_match
    when "b1"
      @grid[@boat_1[0][0]][@boat_1[0][1]] = "║  ⚓  ║"
    when "b2"
      @grid[@boat_2[0][0]][@boat_2[0][1]] = "║  ⚓  ║"
      # when "b5"
      #   @grid[@boat_5[0][0]][@boat_5[0][1]] = "║  ⚓  ║"
      #   @grid[@boat_5[1][0]][@boat_5[1][1]] = "║  ⚓  ║"
      # when "b6"
      #   @grid[@boat_6[0][0]][@boat_6[0][1]] = "║  ⚓  ║"
      #   @grid[@boat_6[1][0]][@boat_6[1][1]] = "║  ⚓  ║"
    end
  end

  def check_if_all_boats_hit
    #There should be 18 boat symbols hit to win the game. Count them, ignoring the first element of the grid, which is a string containing the letters in.
    sum = 0
    @grid[(1..@grid_size)].each do |array|
      sum += array.count("║  ⚓  ║")
    end
    if sum == count_total_number_of_boats_to_hit
      @game_is_won = true
    end
  end

  def count_total_number_of_boats_to_hit
    #Add code to automatically work out how many boat targets to hit in total.
    2
  end
end

@b = Battleships.new
@b.display_board
