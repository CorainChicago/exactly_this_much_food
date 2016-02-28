require_relative '../order_presenter'

RSpec.describe OrderPresenter do

   def capture_standard_output(&block)
    original_stream = $stdout
    $stdout = mock = StringIO.new
    yield
    mock.string.chomp
    ensure
    $stdout = original_stream
  end

  let(:presenter) { OrderPresenter.new }

  describe "#message_error_enter_file_name_again" do 
    it "displays the message about an error and needing to enter the file name again" do
      output = capture_standard_output { presenter.message_error_enter_file_name_again }
      expect(output).to eq "There was an error reading the file, please make sure the file name is entered correctly and in this folder (not listed in a sub-directory)."
    end
  end

#   describe "#message_results" do 

#     it "prints the possible orders found for the user" do 
#       order.load_file
#       order.parse
#       order.get_target_price
#       order.menu_array
#       order.convert_array_to_hash
#       solutions = order.find_orders
#       formatted_results = order.format_results(solutions)
#       output = capture_standard_output { order.message_results(solutions, formatted_results)}
#       expect(output).to eq "\nYou have 2 options which add up to the target price of $15.05.\n\n\nHere is option 1: \n\n7 of the mixed fruit\n\n\nHere is option 2: \n\n2 of the hot wings\n1 of the mixed fruit\n1 of the sampler plate"
#     end
#   end

#   it "displays an error message if no solutions are found" do
#     order.load_file
#     order.check_filename
#     order.parse
#     order.get_target_price
#     order.menu_array
#     order.convert_array_to_hash 
#     order.target_price = "0.00"
#     solutions = order.find_orders
#     formatted_results = order.format_results(solutions)
#     expect(order.target_price).to eq "0.00"
#     output = capture_standard_output { order.message_results(solutions, formatted_results)}
#     expect(output).to eq "We didn't find any possible combinations to match the amount you want to spend. You can update the file and rerun the program."
#   end
# end
end
