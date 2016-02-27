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
    order.find_orders
    order.format_results
    order.message_results
    order.offer_to_repeat
  end

  def clear_screen_and_move_to_home
    print "\e[2J"
    print "\e[H"
  end


end