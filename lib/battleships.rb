class Battleships

  attr_accessor :box_row_1, :box_row_2, :box_row_3, :box_row_4, :box_row_5, :box_row_6, :box_row_7, :box_row_8, :box_row_9, :selected_box_number, :box_1_variable, :box_2_variable, :box_3_variable, :box_4_variable, :box_5_variable, :box_6_variable, :box_7_variable, :box_8_variable, :box_9_variable

  def initialize
    create_initial_board
  end

  def construct_board
    self.box_row_1 = ["╔","═","═","═","═","═","╗""╔","═","═","═","═","═","╗","╔","═","═","═","═","═","╗"]
    self.box_row_2 = ["║"," "," ",box_1_variable," "," ","║","║"," "," ",box_2_variable," "," ","║","║"," "," ",box_3_variable," "," ","║"]
    self.box_row_3 = ["╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝"]
    self.box_row_4 = ["╔","═","═","═","═","═","╗""╔","═","═","═","═","═","╗","╔","═","═","═","═","═","╗"]
    self.box_row_5 = ["║"," "," ",box_4_variable," "," ","║","║"," "," ",box_5_variable," "," ","║","║"," "," ",box_6_variable," "," ","║"]
    self.box_row_6 = ["╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝"]
    self.box_row_7 = ["╔","═","═","═","═","═","╗""╔","═","═","═","═","═","╗","╔","═","═","═","═","═","╗"]
    self.box_row_8 = ["║"," "," ",box_7_variable," "," ","║","║"," "," ",box_8_variable," "," ","║","║"," "," ",box_9_variable," "," ","║"]
    self.box_row_9 = ["╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝","╚","═","═","═","═","═","╝"]
  end

  def join_full_box
    construct_board
    box_row_1_joined = self.box_row_1.join
    box_row_2_joined = self.box_row_2.join
    box_row_3_joined = self.box_row_3.join
    box_row_4_joined = self.box_row_4.join
    box_row_5_joined = self.box_row_5.join
    box_row_6_joined = self.box_row_6.join
    box_row_7_joined = self.box_row_7.join
    box_row_8_joined = self.box_row_8.join
    box_row_9_joined = self.box_row_9.join
    @joined_box = "#{box_row_1_joined}\n#{box_row_2_joined}\n#{box_row_3_joined}\n#{box_row_4_joined}\n#{box_row_5_joined}\n#{box_row_6_joined}\n#{box_row_7_joined}\n#{box_row_8_joined}\n#{box_row_9_joined}"
  end

  def create_initial_board
    self.box_1_variable = "1"
    self.box_2_variable = "2"
    self.box_3_variable = "3"
    self.box_4_variable = "4"
    self.box_5_variable = "5"
    self.box_6_variable = "6"
    self.box_7_variable = "7"
    self.box_8_variable = "8"
    self.box_9_variable = "9"
    join_full_box
  end

  def display_board
    puts @joined_box
  end

  def take_user_input
    puts "Please pick a number to 'attack'"
    self.selected_box_number = gets.chomp.to_i
  end

  def mark_as_hit_or_miss
    case self.selected_box_number
    when 1
      self.box_1_variable = "☠"
    when 2
      self.box_2_variable = "⚓"
    when 3
      self.box_3_variable = "☠"
    when 4
      self.box_4_variable = "☠"
    when 5
      self.box_5_variable = "☠"
    when 6
      self.box_6_variable = "☠"
    when 7
      self.box_7_variable = "☠"
    when 8
      self.box_8_variable = "☠"
    when 9
      self.box_9_variable = "⚓"
    end
    join_full_box
  end

end

