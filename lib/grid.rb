class Grid

  attr_reader :grid

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
    @letter_collection = ("A".."Z").to_a
    @grid_size = 10
    construct_initial_grid
  end

  def construct_initial_grid
    construct_box_rows
    prepend_numbers
    prepend_letters
  end

  def construct_box_rows
    @grid = []
    @grid_size.times do 
      @grid << construct_initial_row
    end
  end
end

def construct_initial_row
  initial_box_row = ["  "]
  initial_box_row[0] << ("╔═════╗" * @grid_size) + "\n"
  @grid_size.times {initial_box_row << "║  ☺  ║"}
  initial_box_row << "\n  "
  initial_box_row[@grid_size + 1] << ("╚═════╝" * @grid_size) + "\n"
  initial_box_row
end

def prepend_numbers
  @grid.each_with_index do |array, index|
    if index < 9
      array[0] << (index + 1).to_s + " "
    else
      array[0] << (index + 1).to_s
    end
  end

  def prepend_letters
    letters_string = "  "
    value = 0
    while value < @grid_size
      letters_string << "   #{@letter_collection[value]}   "
      value += 1
    end
    letters_string << "\n"
    @grid = @grid.unshift(letters_string)
  end

  def display_board
    @output.print @grid.join
  end

end
