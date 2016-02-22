require_relative 'order_filler'

class Menu
  attr_accessor :target_price
  attr_reader :menu_array, :menu_hash, :file

  include OrderFiller

  def initialize
    @menu_array = []
    @target_price = ''
    @file = ""
  end

  def clear_screen_and_move_to_home
    print "\e[2J"
    print "\e[H"
  end

  def welcome
    clear_screen_and_move_to_home
    puts "Welcome to Exact Order! \n\nThis app will provide options from a file which match the amount provided on the first line.\nTo use this application, please type the name of text file you need evaluated (such as a menu) and press enter. \n \nThe file needs to be in the same folder as the application and be a text file."  
  end

  def load_file
    @file = gets.chomp
  end

  def check_filename
    if @file[-4..-1] != ".txt" 
      @file = @file << ".txt"
    end
  end

  def parse
    begin
      File.readlines(@file).each do |line|
       @menu_array << line.chop
      end
    rescue
      puts "There was an error reading the file, please make sure the file name is entered correctly."
      load_file
      check_filename
      parse
    end
  end

  def get_target_price
    @target_price = @menu_array.shift.delete("$")
  end

  def remove_whitespace
    menu_array.map! {|item| item.strip }
  end

  def convert_array_to_hash
    result = @menu_array.map! {|string| string.partition(",")}
    result = result.each {|arr| arr.delete_if{|item| item == ","}}
    result.flatten!
    @menu_hash = Hash[result.each_slice(2).to_a]
  end

end


