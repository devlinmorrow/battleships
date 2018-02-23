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
    @grid_size = 2
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
    p @boat_1 = generate_boats_length_1
    p @boat_2 = generate_boats_length_1
    # p @boat_3 = generate_boats_length_1
    # p @boat_4 = generate_boats_length_1
    until ensure_no_boat_the_same(@boat_1,@boat_2)
      @boat_2 = generate_boats_length_1
    end

    p @boat_1
    p @boat_2
    # p @boat_3
    # p @boat_4

    #    #boat 5
    #    b5r1 = rand(1..9)
    #    b5c1 = rand(1..9)
    #    @boat_5 = [[b5r1,b5c1],[b5r1,b5c1]]
    #    x = rand(0..1)
    #    @boat_5[1][x] = @boat_5[1][x] + 1
    #    generate_boat_6
    #    until (@boat_5 & @boat_6).empty?
    #     generate_boat_6
    #    end 
  end

  def generate_boats_length_1
    r1 = rand(1..@grid_size)
    c1 = rand(1..@grid_size)
    [[r1,c1]]
  end

  def generate_boat_6
    b6r1 = rand(1..9)
    b6c1 = rand(1..9)
    @boat_6 = [[b6r1,b6c1],[b6r1,b6c1]]
    x = rand(0..1)
    @boat_6[1][x] = @boat_6[1][x] + 1
  end

  def ensure_no_boat_the_same(boat1,boat2)
    (boat1 & boat2).empty?
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
