

class Order
  attr_accessor :menu_array, :total, :menu_hash

  def initialize
    @menu_array = []
    @total = ''
  end

  def instructions
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
    sum = 0
    items.each do |item|
     sum += @menu_hash[item].delete("$").to_f
    end
    return sum
  end

  def possible_orders
  end
end


