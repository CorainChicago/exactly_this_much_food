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
      expect(output).to eq "\nThere was an error reading the file, please make sure the file name is entered correctly and in this folder (not listed in a sub-directory)."
    end
  end

  describe "#message_results" do 

    it "prints the possible orders found for the user" do 
      solutions = [["mixed fruit","mixed fruit","mixed fruit","mixed fruit","mixed fruit","mixed fruit"],["hot wings", "hot wings", "mixed fruit", "sampler plate"]] 
      formatted_results = [[[7, "mixed fruit"]], [[2, "hot wings"], [1, "mixed fruit"], [1, "sampler plate"]]]
      output = capture_standard_output { presenter.message_results("15.05", solutions, formatted_results)}
      expect(output).to eq "\nYou have 2 options which add up to the target price of $15.05.\n\n\nHere is option 1: \n\n7 of the mixed fruit\n\n\nHere is option 2: \n\n2 of the hot wings\n1 of the mixed fruit\n1 of the sampler plate"
    end

    it "displays an error message if no solutions are found"  do
      solutions = []
      formatted_results = []
      output = capture_standard_output { presenter.message_results("15.05", solutions, formatted_results)}
      expect(output).to eq "\nWe didn't find any possible combinations to match the amount you want to spend. You can update the file and rerun the program."
    end
  end

#   
end
