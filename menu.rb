class Menu
  attr_accessor :menu_array, :target_price, :menu_hash, :solutions, :file

  def initialize
    @menu_array = []
    @target_price = ''
    @solutions = []
    @file = ""
  end

  def get_target_price
    @target_price = @menu_array.shift.delete("$")
  end

  def convert_array_to_hash
    result = @menu_array.map! {|string| string.partition(",")}
    result = result.each {|arr| arr.delete_if{|item| item == ","}}
    @menu_hash = Hash[result.flatten!.each_slice(2).to_a]
  end

  # def get_order_total(items)
  #   sum = 0.00
  #   items.each do |item|
  #     sum += @menu_hash[item].delete("$").to_f
  #   end
  #   return '%.02f' % sum
  # end

  # def find_orders
  #   @solutions = []
  #   @menu_keys_array = Array.new(@menu_hash.keys)
  #   possible_order = []
  #   add_items(possible_order, 0)
  #   return @solutions
  # end

  # def add_items(possible_order, count)
  #   for i in 0..@menu_keys_array.length - 1
  #     temp_order = possible_order.map{ |item| item }
  #     temp_order << @menu_keys_array[i]
  #     temp_order.sort!
  #     if get_order_total(temp_order) == @target_price
  #       unless @solutions.include?(temp_order)
  #         @solutions << temp_order
  #         return @solutions
  #       end
  #     elsif get_order_total(temp_order).to_f < @target_price.to_f
  #       add_items(temp_order, count)  
  #     end
  #   end
  # end

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
    return formatted_solutions
  end
end


