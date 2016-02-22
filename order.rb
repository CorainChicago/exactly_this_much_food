

class Order
  attr_accessor :menu_array, :total, :menu_hash, :solutions, :file

  def initialize
    @menu_array = []
    @total = ''
    @solutions = []
    @file = ""
  end

  def welcome
    puts "Welcome to 'Exact Order'! \nThis app will provide options from a txt file which match the amount provided on the first line.\nTo use this application, please type the name of file you need evaluated (such as a menu) and press enter.\n"  
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
      puts "There was an error reading the file, please enter the filename again."
      load_file
      check_filename
      parse
    end
  end

  def get_total
    @total = @menu_array.shift.delete("$")
  end

  def remove_whitespace
    menu_array.map! {|item| item.strip }
  end

  def convert_to_hash
    #divide at the commas
    result = menu_array.map! {|string| string.partition(",")}
    #remove the commas from the nested arrays of strings
    result = result.each {|arr| arr.delete_if{|item| item == ","}}
    #flatten the nested arrays
    result.flatten!
    #create the hash 
    @menu_hash = Hash[result.each_slice(2).to_a]
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
      if add_prices(temp_order) == @total
        unless @solutions.include?(temp_order)
          @solutions << temp_order
          return @solutions
        end
      elsif add_prices(temp_order).to_f < @total.to_f
        add_items(temp_order, count)  
      end
    end
  end

  def message_results
    puts "You have #{@solutions.length} options: \n"
    @solutions.each do |solution|
    solution.each  do |s| 
      puts s
    end
    puts "\n \n Next option\n"
  end
  end

end


