class Battleships

  attr_accessor :selected_box_coordinates, :box_1_variable, :box_2_variable, :box_3_variable, :box_4_variable, :box_5_variable, :box_6_variable, :box_7_variable, :box_8_variable, :box_9_variable, :guesses_left, :game_is_won, :joined_box

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 6
    @game_is_won = false
  end

  def box_drawing
    @top_box_line = "╔═════╗"
    @mid_box_line = "║  ☺  ║"
    @bot_box_line = "╚═════╝"
  end

  def construct_row
    box_drawing
    @grid_size = 3
  @full_row = [@top_box_line * @grid_size]
  @full_row << "\n"
  @grid_size.times {@full_row << @mid_box_line}
  @full_row << "\n"
  @full_row << @bot_box_line * @grid_size
  p @full_row
  end

  def construct_full_grid
    @full_grid = []
    @grid_size.times do 
      @full_grid << @full_row 
      @full_grid << "\n" 
    end
    print @full_grid.join
  end

  def display_board
    @output.puts @joined_box
  end

  def take_user_input
    @output.puts "Please pick a number to 'attack'"
    @selected_box_coordinates = @input.gets.chomp.to_s
  end

  def mark_as_hit_or_miss
    case @selected_box_coordinates
    when "A1"
      @box_1_variable = "☠"
    when "B1"
      @box_2_variable = "⚓"
    when "C1"
      @box_3_variable = "☠"
    when "A2"
      @box_4_variable = "☠"
    when "B2"
      @box_5_variable = "☠"
    when "C2"
      @box_6_variable = "☠"
    when "A3"
      @box_7_variable = "☠"
    when "B3"
      @box_8_variable = "☠"
    when "C3"
      @box_9_variable = "⚓"
    end
    construct_board
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

