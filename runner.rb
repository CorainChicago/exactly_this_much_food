require_relative 'order'
order = Order.new

order.parse("test.txt")
order.remove_whitespace
order.get_total
order.menu_array
order.convert_to_hash
order.find_orders
order.message_results