require_relative '../order'


RSpec.describe Order do

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

  let (:order) { Order.new }

  describe "attributes" do
    it "messages instructions for the program" do 
      output = capture_standard_output { order.welcome}
      expect(output).to be_a_kind_of String
    end 
  end

  describe "#load_file" do
    it "takes the user's input from the command line" do 
      expect(order.load_file).to eq 'test.txt'
    end
  end

  describe "#check_filename" do 
      before do
        $stdin = StringIO.new("test\n")
      end
    it "checks a filename" do 
      order2 = Order.new
      order2.load_file
      order2.check_filename
      expect(order2.file).to eq "menu_files/test.txt"
    end
  end

  describe "#parse" do 
    it "reads the file given and returns an array of each line of text" do 
      order.load_file
      result = order.parse
      p result
      expect(result[0]).to eq "$15.05"
      expect(result.length).to eq 7
    end
    it "adds the lines to th @menu_array" do
    expect(order.menu_array).to be_empty
    order.load_file
    order.parse
    expect(order.menu_array).not_to be_empty
    end
  end

  describe "#get_target_price" do 
    it "takes the first item from the menu_array" do
      order.load_file
      order.parse
      goal = order.get_target_price
      expect(goal).to eq  "15.05"
    end 
  end

  describe "#convert_to_hash" do 

    before do  
      order.load_file 
      order.parse
      order.get_target_price
      order.menu_array
      order.convert_to_hash
    end

    it "converts the array into a hash" do
      expect(order.menu_hash).to be_a(Hash)
    end

    it "produces a hash with the item as key and price as value" do
      expect(order.menu_hash["mixed fruit"]).to eq "$2.15"
    end

  end

  describe "#add_prices" do
    before do  
      order.load_file 
      order.parse
      order.get_target_price
      order.menu_array
      order.convert_to_hash
    end
    
    it "finds the solutions matching" do
      expect(order.add_prices(["mixed fruit", "french fries"])).to eq "4.90"
    end
  end

  describe "#find_orders" do
    before do  
      order.load_file 
      order.parse
      order.get_target_price
      order.menu_array
      order.convert_to_hash
    end
    
    it "finds two solutions for the test.txt file" do
      result = order.find_orders
      p result
      expect(result.length).to eq 2
    end

    it "fills an empty solutions arrays" do 
      expect(order.solutions).to be_empty
      order.find_orders
      expect(order.solutions).not_to be_empty
    end

  end

  describe "#possible_orders" do
    it "will return 2 order options for a specific target_price from the menu_hash" do
      order.load_file
      order.parse
      order.get_target_price
      order.menu_array
      order.convert_to_hash
      result = order.find_orders
      expect(result.length).to eq 2
      expect(result).to eq [["mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit"], ["hot wings", "hot wings", "mixed fruit", "sampler plate"]]
    end 
  end

  describe "#format_results" do 
    it "formats the @solutions display to provide the count and item" do 
      order.load_file
      order.parse
      order.get_target_price
      order.menu_array
      order.convert_to_hash
      order.find_orders
      results = order.format_results
      expect(results).to eq [[[7, "mixed fruit"]], [[2, "hot wings"], [1, "mixed fruit"], [1, "sampler plate"]]]
    end
  end

  describe "#message_results" do 

    it "prints the possible orders found for the user" do 
      order.load_file
      order.parse
      order.get_target_price
      order.menu_array
      order.convert_to_hash
      order.find_orders
      output = capture_standard_output { order.message_results}
      expect(output).to eq "\nYou have 2 options.\n\n\nHere is option 1: \n\n7 of the mixed fruit\n\n\nHere is option 2: \n\n2 of the hot wings\n1 of the mixed fruit\n1 of the sampler plate"
    end
  end

  it "displays an error message if no sulutions are found" do
    order.load_file
    order.parse
    order.get_target_price
    order.menu_array
    order.convert_to_hash 
    order.target_price = "0.00"
    order.find_orders
    expect(order.target_price).to eq "0.00"
    output = capture_standard_output { order.message_results}
    expect(output).to eq "We didn't find any possible combinations to match the amount you want to spend. Do you want to try again with a new amount? Y/N"
  end

end