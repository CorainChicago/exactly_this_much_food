require_relative 'menu.rb'
require_relative 'messenger.rb'

class OrderPresenter
  attr_accessor :menu

  include Messenger

  def initialize
    @menu = Menu.new
  end

  def run
    clear_screen_and_move_to_home
    message_welcome
    file = load_file
    menu.file = check_filename(file)
    menu.menu_array = parse(menu.file)
    menu.get_target_price
    menu.menu_array
    menu.convert_array_to_hash
    solutions = menu.find_menus
    formatted_solutions = menu.format_results(solutions)
    message_results(menu.get_target_price, solutions, formatted_solutions)
    offer_to_repeat
  end

  def clear_screen_and_move_to_home
    print "\e[2J"
    print "\e[H"
  end

  def load_file
    menu.file = gets.chomp
  end

  def check_filename(file)
    if file[-4..-1] != ".txt" 
      file = file << ".txt"
    end
  end

  def parse(file)
    menu_array = []
    begin
      data = File.open(file)
      data.each do |line|
        menu_array << line.chomp
      end
    rescue
      message_error_enter_file_name_again
      file = load_file
      menu.file = check_filename(file)
      menu.menu_array = parse(menu.file)
    end
    return menu_array
  end

  def message_results(target_price, solutions, formatted_results)
    if solutions.empty?
      message_no_results
    else
      counter = 1
      message_number_solutions_with_price(solutions.length, target_price)
      formatted_results.each do |menu|
        puts "\n\nHere is option #{counter}: \n\n"
        menu.each do |item|
          puts "#{item[0]} of the #{item[1]}"
        end
        counter += 1
      end
    end
  end

  def offer_to_repeat
    message_ask_to_repeat
    response = gets.chomp
    if response == 'Y' || response == 'y'
      menu.menu_array = []
      menu.target_price = ''
      menu.solutions = []
      menu.file = ""
      run
    else
      message_have_a_great_meal
      return
    end
  end


end