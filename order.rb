
class Order
  attr_accessor :menu_array, :target_price, :menu_hash, :solutions, :file

  def initialize
    @menu_array = []
    @target_price = ''
    @solutions = []
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

  def convert_to_hash
    result = menu_array.map! {|string| string.partition(",")}
    result = result.each {|arr| arr.delete_if{|item| item == ","}}
    @menu_hash = Hash[result.flatten!.each_slice(2).to_a]
  end

  def add_prices(items)
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
      temp_order = possible_order.map{|item| item}
      temp_order << @menu_keys_array[i]
      temp_order.sort!
      if add_prices(temp_order) == @target_price
        unless @solutions.include?(temp_order)
          @solutions << temp_order
          return @solutions
        end
      elsif add_prices(temp_order).to_f < @target_price.to_f
        add_items(temp_order, count)  
      end
    end
  end

  def format_results
    formatted_solutions = []
    @solutions.each do |solution|
      unique_solutions = solution.uniq
      option = []
      unique_solutions.each do |s|
        option << [solution.count(s), s]
      end
      formatted_solutions << option
    end
    return formatted_solutions
  end

  def message_results
    if @solutions.empty?
      puts "We didn't find any possible combinations to match the amount you want to spend. Do you want to try again with a new amount? Y/N"
    else
      counter = 1
      puts "\nYou have #{@solutions.length} options."
      format_results.each do |order|
        puts "\n\nHere is option #{counter}: \n\n"
        order.each do |item|
          puts "#{item[0]} of the #{item[1]}"
        end
        counter += 1
      end
    end
  end

end


