# initialize it with the arguments needed and then not need them for arguments for the methods. Move it into a class

module OrderFinder

  def get_order_total(items, menu_hash)
    sum = 0.00
    items.each do |item|
      sum += menu_hash[item].delete("$").to_f
    end
    return '%.02f' % sum
  end

  def find_orders(menu_hash, target_price)
    solutions = []
    possible_order = []
    add_items(possible_order, target_price, menu_hash, solutions)
    solutions
  end

  # Check budget left before the next pass to  get_order_total to keeps from checking items over the budget amount left.


  def add_items(possible_order, target_price, menu_hash, solutions)
    for i in 0..menu_hash.keys.length - 1
      temp_order = possible_order.map{ |item| item }
      temp_order << menu_hash.keys[i]
      temp_order.sort!
      if get_order_total(temp_order, menu_hash) == target_price
        unless solutions.include?(temp_order)
          solutions << temp_order
          return solutions
        end
      elsif get_order_total(temp_order, menu_hash).to_f < target_price.to_f
        add_items(temp_order, target_price, menu_hash, solutions)  
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
    return formatted_solutions
  end


end