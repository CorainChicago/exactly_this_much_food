require_relative 'order'
order = Order.new

order.welcome
order.load_file
order.parse
order.remove_whitespace
order.get_total
order.menu_array
order.convert_to_hash
order.find_orders
order.message_results