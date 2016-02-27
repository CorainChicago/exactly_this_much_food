require_relative '../messenger'

RSpec.describe Messenger do

  class Example
    include Messenger
  end

  def capture_standard_output(&block)
    original_stream = $stdout
    $stdout = mock = StringIO.new
    yield
    mock.string.chomp
    ensure
    $stdout = original_stream
  end

  let(:example) { Example.new }

  describe "#message_error_enter_file_name_again" do 
    it "displays the message about an error and needing to enter the file name again" do
      output = capture_standard_output { example.message_error_enter_file_name_again }
      expect(output).to eq "There was an error reading the file, please make sure the file name is entered correctly and in this folder (not listed in a sub-directory)."
    end
  end
  
  describe "#message_welcome" do
    it "displays a wecome message" do 
      output = capture_standard_output { example.message_welcome }
      expect(output).to eq "Welcome to Exact Order! \n\nThis app will provide options from a file which match the amount provided on the first line. To use this application, please type the name of text file you need evaluated (such as a menu) and press enter. \n \nThe text file needs to be in the same folder as the application and be a text file."  
    end
  end

end