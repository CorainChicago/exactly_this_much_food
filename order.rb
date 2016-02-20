

class Order
  attr_accessor :menu_array, :total, :menu_hash

  def initialize
    @menu_array = []
    @total = ''
  end

  def welcome
    p "Please enter the file you want to upload"
  end

  def parse(filename)
    File.readlines(filename).each do |line|
     @menu_array << line.chop
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
      p temp_order
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

end


