require_relative 'order.rb'

class OrderPresenter
  attr_accessor :order

  def initialize
    @order = Order.new
  end

  def run
    order.welcome
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
end