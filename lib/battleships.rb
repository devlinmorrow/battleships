class Battleships

  attr_accessor :selected_box_coordinates, :guesses_left, :game_is_won, :grid

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 20
    @game_is_won = false
    @letter_collection = ("A".."Z").to_a
    @top_box_line = "╔═════╗"
    @bot_box_line = "╚═════╝"
    @grid_size = 10
    construct_initial_grid
  end

  def construct_initial_row
    @neutral_mid_box_line = "║  ☺  ║" 
    initial_box_row = ["  "]
    initial_box_row[0] << @top_box_line * @grid_size
    initial_box_row[0] << "\n"
    @grid_size.times {initial_box_row << @neutral_mid_box_line}
    initial_box_row << "\n  "
    initial_box_row[@grid_size + 1] << @bot_box_line * @grid_size
    initial_box_row[@grid_size + 1] << "\n"
    initial_box_row
  end

  def construct_initial_grid
    @grid = []
    @grid_size.times do 
      @grid << construct_initial_row
    end
    @grid.each_with_index do |a, i|
      if i < 9
        a[0] << (i + 1).to_s
        a[0] << " "
      else
        a[0] << (i + 1).to_s
      end
    end
    @letters_string = "  "
    x = 0
    while x < @grid_size
      @letters_string << "   #{@letter_collection[x]}   "
      x += 1
    end
    @letters_string << "\n"
    @grid = @grid.unshift(@letters_string)
  end

  def display_board
    @output.print @grid.join
  end

  def take_user_input
    @output.puts "Please pick the coordinates you wish to attack"
    @selected_box_coordinates = @input.gets.chomp.to_s
  end

  def mark_as_hit_or_miss
    case @selected_box_coordinates
    when "B6"
      @grid[6][2] = "║  ⚓  ║"
    when "B7"
      @grid[7][2] = "║  ⚓  ║"
    when "C10"
      @grid[10][3] = "║  ⚓  ║"
    when "J4"
      @grid[4][10] = "║  ⚓  ║"
    when "B2", "C2"
      @grid[2][3] = "║  ⚓  ║"
      @grid[2][4] = "║  ⚓  ║"
    when "C3", "D3", "E3"
      @grid[3][3] = "║  ⚓  ║"
      @grid[3][4] = "║  ⚓  ║"
      @grid[3][5] = "║  ⚓  ║"
    when "A8", "B8", "C8"
      @grid[8][1] = "║  ⚓  ║"
      @grid[8][2] = "║  ⚓  ║"
      @grid[8][3] = "║  ⚓  ║"
    when "H8", "H9"
      @grid[8][7] = "║  ⚓  ║"
      @grid[9][7] = "║  ⚓  ║"
    when "I7", "I8", "I9", "I10"
      @grid[7][9] = "║  ⚓  ║"
      @grid[8][9] = "║  ⚓  ║"
      @grid[9][9] = "║  ⚓  ║"
      @grid[10][9] = "║  ⚓  ║"
    else
      coordinates_array = @selected_box_coordinates.chars
      x = coordinates_array[0]
      l = @letter_collection.index(x) + 1
      n = coordinates_array[1].to_i
      @grid[n][l] = "║  ☠  ║"
    end
  end

  def run_guess
    take_user_input
    mark_as_hit_or_miss
    display_board
    @guesses_left -= 1
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

  def check_if_all_boats_hit
    sum = 0
    @grid.each do |ele|
      sum += ele.count("║  ⚓  ║")
    end
    sum -= 62
    if sum == 18
      @game_is_won = true
    end
  end
end

@b = Battleships.new
@b.display_board
