puts '╔════╦════╦════╗'
puts '║    ║    ║    ║'
puts '╠════╬════╬════╣'
puts '║    ║    ║    ║'
puts '╠════╬════╬════╣'
puts '║    ║    ║    ║'
puts '╚════╩════╩════╝'



  def construct_initial_row
    @neutral_mid_box_line = "║  ☺  ║" 
    initial_box_row = [" "]
    initial_box_row[0] << @top_box_line * @grid_size
    initial_box_row[0] << "\n"
    @grid_size.times {initial_box_row << @neutral_mid_box_line}
    initial_box_row << "\n "
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
      a[0] << (i + 1).to_s
    end
    p @grid
  end
