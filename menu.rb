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

  # def format_results(solutions)
  #   formatted_solutions = []
  #   solutions.each do |solution|
  #     unique_solutions = solution.uniq
  #     option = []
  #     unique_solutions.each do |s|
  #       option << [solution.count(s), s]
  #     end
  #     formatted_solutions << option
  #   end
  #   return formatted_solutions
  # end
end


