class Battleships

  attr_accessor :selected_box_coordinates, :guesses_left, :game_is_won, :grid

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 6
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
    when "A1","B2","C2","D2"
      @grid[1][1] = "║  ⚓  ║"
      @grid[1][2] = "║  ⚓  ║"
      @grid[1][3] = "║  ⚓  ║"
      @grid[1][4] = "║  ⚓  ║"
    else
      @grid[1][7] = "☠"
    end
  end

  def run_guess
    take_user_input
    mark_as_hit_or_miss
    display_board
    @guesses_left -= 1
  end

  def play_game
    @output.puts "Welcome to Battleships! You have 5 guesses to hit 2 boats"
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
    if @box_2_variable == "⚓" && @box_9_variable == "⚓"
      @game_is_won = true
    end
  end

end

b = Battleships.new
b.display_board
