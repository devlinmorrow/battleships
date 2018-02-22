class Battleships

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
  end

  def construct_initial_grid
    @grid = []
    @grid_size.times do 
      @grid << construct_initial_row
    end

    #Append a number to each row, adding a space after single digits to allow room for double-digit numbers.
    @grid.each_with_index do |array, index|
      if index < 9
        array[0] << (index + 1).to_s + " "
      else
        array[0] << (index + 1).to_s
      end
    end

    #Finally, append the row of letters.
    letters_string = "  "
    value = 0
    while value < @grid_size
      letters_string << "   #{@letter_collection[value]}   "
      value += 1
    end
    letters_string << "\n"
    @grid = @grid.unshift(letters_string)
  end

  def construct_initial_row
    initial_box_row = ["  "]
    initial_box_row[0] << ("╔═════╗" * @grid_size) + "\n"
    @grid_size.times {initial_box_row << "║  ☺  ║"}
    initial_box_row << "\n  "
    initial_box_row[@grid_size + 1] << ("╚═════╝" * @grid_size) + "\n"
    initial_box_row
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

  def display_board
    @output.print @grid.join
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
    #Boat 2
    p b1r1 = rand(1..9)
    p b1c1 = rand(1..9)
    @boat_2 = [[b1r1,b1c1],[b1r1+1,b1c1]]
  end

  def mark_as_hit_or_miss
    coordinates_array = @selected_box_coordinates.chars
    #If user has selected 10, it will be split into separate chars, so amend this then relate the user input to the grid coordinates.
    if coordinates_array[2] == "0"
      coordinates_array.pop
      coordinates_array[1] = "10"
    end
    column = @letter_collection.index(coordinates_array[0]) + 1
    row = coordinates_array[1].to_i

    #Mark as hit or miss.
    if @boat_2.include?([row,column])
      @grid[@boat_2[0][0]][@boat_2[0][1]] = "║  ⚓  ║"
      @grid[@boat_2[1][0]][@boat_2[1][1]] = "║  ⚓  ║"
    else
      @grid[row][column] = "║  ☠  ║"
    end
  end

  def check_if_all_boats_hit
    #There should be 18 boat symbols hit to win the game. Count them, ignoring the first element of the grid, which is a string containing the letters in.
    sum = 0
    @grid[(1..@grid_size)].each do |array|
      sum += array.count("║  ⚓  ║")
    end
    if sum == 18
      @game_is_won = true
    end
  end
end

  @b = Battleships.new
  @b.display_board
