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

  describe "#get_target_price" do 
    it "takes the first item from the menu_array" do
      order.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      goal = order.get_target_price
      expect(goal).to eq  "15.05"
    end 
  end

  describe "#convert_array_to_hash" do 

    before do  
      order.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      order.get_target_price
      order.convert_array_to_hash
    end

    it "converts the array into a hash" do
      expect(order.menu_hash).to be_a(Hash)
    end

    it "produces a hash with the item as key and price as value" do
      expect(order.menu_hash["mixed fruit"]).to eq "$2.15"
    end

  end

  describe "#get_order_total" do
    before do  
      order.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      order.get_target_price
      order.convert_array_to_hash
    end
    
    it "finds the solutions matching" do
      expect(order.get_order_total(["mixed fruit", "french fries"])).to eq "4.90"
    end
  end

  describe "#find_orders" do
    before do  
      order.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      order.get_target_price
      order.convert_array_to_hash
    end
    
    it "finds two solutions for the test.txt file" do
      result = order.find_orders
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
      order.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      order.get_target_price
      order.convert_array_to_hash
      result = order.find_orders
      expect(result.length).to eq 2
      expect(result).to eq [["mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit"], ["hot wings", "hot wings", "mixed fruit", "sampler plate"]]
    end 
  end

  describe "#format_results" do 
    it "formats the @solutions display to provide the count and item" do 
      order.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      order.get_target_price
      order.convert_array_to_hash
      solutions = order.find_orders
      results = order.format_results(solutions)
      expect(results).to eq [[[7, "mixed fruit"]], [[2, "hot wings"], [1, "mixed fruit"], [1, "sampler plate"]]]
    end
  end


end