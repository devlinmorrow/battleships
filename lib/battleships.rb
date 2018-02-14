class Battleships

  attr_accessor :box_top, :box_mid, :box_bot, :selected_box_number, :box_1_variable, :box_2_variable

  def initialize
    create_boxes
  end

  def construct_box
    self.box_top = ["╔","═","═","═","═","═","╗""╔","═","═","═","═","═","╗"]

    self.box_mid = ["║"," "," ",box_1_variable," "," ","║","║"," "," ",box_2_variable," "," ","║"]

    self.box_bot = ["╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝"]

  end

  def join_full_box
    construct_box
    @box_top_joined = self.box_top.join
    @box_mid_joined = self.box_mid.join
    @box_bot_joined = self.box_bot.join
    @joined_box = "#{@box_top_joined}\n#{@box_mid_joined}\n#{@box_bot_joined}"
  end

  def create_boxes
    self.box_1_variable = "1"
    self.box_2_variable = "2"
    join_full_box
  end

  def display_board
  puts @joined_box
  end

  def take_user_input
    puts "Please pick a number to 'attack'"
    self.selected_box_number = gets.chomp.to_i
  end

  def mark_as_attacked_but_missed
    self.box_mid[3] = "☠"
  end

  def mark_as_attacked_and_hit
    self.box_mid[3] = "⚓"
  end

end

