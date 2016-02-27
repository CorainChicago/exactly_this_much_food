require_relative 'order.rb'
require_relative 'messenger.rb'

class OrderPresenter
  attr_accessor :order

  include Messenger

  def initialize
    @order = Order.new
  end

  def run
    clear_screen_and_move_to_home
    order.message_welcome
    order.load_file
    order.check_filename
    order.parse
    order.get_target_price
    order.menu_array
    order.convert_array_to_hash
    solutions = order.find_orders
    formatted_solutions = order.format_results(solutions)
    message_results(order.get_target_price, solutions, formatted_solutions)
    order.offer_to_repeat
  end

  def clear_screen_and_move_to_home
    print "\e[2J"
    print "\e[H"
  end

  def message_results(target_price, solutions, formatted_results)
    if solutions.empty?
      message_no_results
    else
      counter = 1
      puts "\nYou have #{solutions.length} options which add up to the target price of $#{target_price}."
      formatted_results.each do |order|
        puts "\n\nHere is option #{counter}: \n\n"
        order.each do |item|
          puts "#{item[0]} of the #{item[1]}"
        end
        counter += 1
      end
    end
  end


end