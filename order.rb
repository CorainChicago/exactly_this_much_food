require_relative 'messenger'

class Order
  attr_accessor :menu_array, :target_price, :menu_hash, :solutions, :file

  include Messenger

  def initialize
    @menu_array = []
    @target_price = ''
    @solutions = []
    @file = ""
  end

  def load_file
    @file = gets.chomp
  end

  def check_filename
    if @file[-4..-1] != ".txt" 
      @file = @file << ".txt"
    end
  end

  def parse(file)
    menu_array = []
    begin
      data = File.open(@file)
      data.each do |line|
        @menu_array << line.chomp
      end
    rescue
      message_error_enter_file_name_again
      load_file
      check_filename
      parse
    end
    return @menu_array
  end

  def get_target_price
    @target_price = @menu_array.shift.delete("$")
  end

  def convert_array_to_hash
    result = @menu_array.map! {|string| string.partition(",")}
    result = result.each {|arr| arr.delete_if{|item| item == ","}}
    @menu_hash = Hash[result.flatten!.each_slice(2).to_a]
  end

  def get_order_total(items)
    sum = 0.00
    items.each do |item|
      sum += @menu_hash[item].delete("$").to_f
    end
    return '%.02f' % sum
  end

  def find_orders
    @solutions = []
    @menu_keys_array = Array.new(@menu_hash.keys)
    possible_order = []
    add_items(possible_order, 0)
    return @solutions
  end

  def add_items(possible_order, count)
    for i in 0..@menu_keys_array.length - 1
      temp_order = possible_order.map{ |item| item }
      temp_order << @menu_keys_array[i]
      temp_order.sort!
      if get_order_total(temp_order) == @target_price
        unless @solutions.include?(temp_order)
          @solutions << temp_order
          return @solutions
        end
      elsif get_order_total(temp_order).to_f < @target_price.to_f
        add_items(temp_order, count)  
      end
    end
  end

  def format_results(solutions)
    formatted_solutions = []
    solutions.each do |solution|
      unique_solutions = solution.uniq
      option = []
      unique_solutions.each do |s|
        option << [solution.count(s), s]
      end
      formatted_solutions << option
    end
    p formatted_solutions
    return formatted_solutions
  end

  def offer_to_repeat
    message_ask_to_repeat
    response = gets.chomp
    if response == 'Y' || response == 'y'
      @menu_array = []
      @target_price = ''
      @solutions = []
      @file = ""
      puts "\nPlease enter the name of the text file you want to use.\n"
      load_file
      file = check_filename
      parse(file)
      target_price = get_target_price
      menu_array
      convert_array_to_hash
      solutions = find_orders
      formatted_results = format_results(solutions)
      message_results(solutions, formatted_results)
      offer_to_repeat
    else
      message_have_a_great_meal
      return
    end
  end

  

end


