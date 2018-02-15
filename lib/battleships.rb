class Battleships

  attr_accessor :selected_box_coordinates, :box_1_variable, :box_2_variable, :box_3_variable, :box_4_variable, :box_5_variable, :box_6_variable, :box_7_variable, :box_8_variable, :box_9_variable, :guesses_left, :game_is_won, :joined_box

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @guesses_left = 6
    @game_is_won = false
    create_initial_board
  end

  def construct_board
    box_row_2 = ["║  ", @box_1_variable, "  ║║  ", @box_2_variable, "  ║║  ", @box_3_variable, "  ║"].join
    box_row_5 = ["║  ", @box_4_variable, "  ║║  ", @box_5_variable, "  ║║  ", @box_6_variable, "  ║"].join
    box_row_8 = ["║  ", @box_7_variable, "  ║║  ", @box_8_variable, "  ║║  ", @box_9_variable, "  ║"].join
    @joined_box = "    A      B      C    \n ╔═════╗╔═════╗╔═════╗\n1#{box_row_2}\n ╚═════╝╚═════╝╚═════╝\n ╔═════╗╔═════╗╔═════╗\n2#{box_row_5}\n ╚═════╝╚═════╝╚═════╝\n ╔═════╗╔═════╗╔═════╗\n3#{box_row_8}\n ╚═════╝╚═════╝╚═════╝"
  end

  def create_initial_board
    @box_1_variable, @box_2_variable, @box_3_variable, @box_4_variable, @box_5_variable, @box_6_variable, @box_7_variable, @box_8_variable, @box_9_variable = ["☺"] * 9
    construct_board
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

