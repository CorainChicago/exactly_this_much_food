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

end