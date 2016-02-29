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

  before do
    $stdin = StringIO.new("test.txt\n")
  end

  let(:presenter) { OrderPresenter.new }

  describe "#load_file" do
    it "takes the user's input from the command line" do 
      expect(presenter.load_file).to eq 'test.txt'
    end
  end

  describe "#check_filename" do

      before do
        $stdin = StringIO.new("test\n")
      end

    it "add '.txt' to a filename when it's missing" do 
      presenter.load_file
      file = presenter.check_filename(presenter.menu.file)
      expect(file).to eq "test.txt"
    end
  end

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

  describe "#parse" do 
    it "reads the file given and returns an array of each line of text" do 
      file = "test.txt"
      menu_array = presenter.parse(file)
      expect(menu_array).to be_a_kind_of(Array)
    end

    it "adds the lines to the menu_array" do
      file = "test.txt"
      menu_array = presenter.parse(file)
      expect(menu_array).not_to be_empty
    end
  end

  describe "#offer_to_repeat" do

    it "asks the user if they want to play again and messages to have a nice meal  if 'Y' or 'y' is not given" do 
      output = capture_standard_output { presenter.offer_to_repeat }
      expect(output).to eq "\n\nDo you want to search another folder? Type 'Y' or 'N'\nHave a great meal." 
    end
  end
end
