require_relative '../order_finder'

RSpec.describe OrderFinder do

  class Example
    attr_accessor :menu_array, :menu_hash
    include OrderFinder

    def initialize
      @menu_array = []
      @menu_hash = {}
    end

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

  describe "#get_order_total" do
    before do  
      example.menu_array = ["mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      example.menu_hash = {"mixed fruit"=>"$2.15", "french fries"=>"$2.75", "side salad"=>"$3.35", "hot wings"=>"$3.55", "mozzarella sticks"=>"$4.20", "sampler plate"=>"$5.80"}
    end
    
    it "adds the prices of the items" do
      expect(example.get_order_total(["mixed fruit", "french fries"], example.menu_hash)).to eq "4.90"
    end

    it "returns the total as a string" do
      expect(example.get_order_total(["mixed fruit", "french fries"], example.menu_hash)).to be_a_kind_of(String)
    end

  end

  describe "#find_orders" do
   before do  
      example.menu_array = ["mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      example.menu_hash = {"mixed fruit"=>"$2.15", "french fries"=>"$2.75", "side salad"=>"$3.35", "hot wings"=>"$3.55", "mozzarella sticks"=>"$4.20", "sampler plate"=>"$5.80"}
    end
    
    it "finds two solutions for the test.txt file" do
      result = example.find_orders(example.menu_hash, "15.05")
      expect(result.length).to eq 2
    end

    it "will return 2 menu options for a specific target_price from the menu_hash" do
      result = example.find_orders(example.menu_hash, "15.05")
      expect(result).to eq [["mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit", "mixed fruit"], ["hot wings", "hot wings", "mixed fruit", "sampler plate"]]
    end 

    it "returns an empty array if no solutions are found" do 
      result = example.find_orders(example.menu_hash, "1.00")
      expect(result).to eq []
    end
  end

  describe "#format_results" do 

    before do  
      example.menu_array = ["mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      example.menu_hash = {"mixed fruit"=>"$2.15", "french fries"=>"$2.75", "side salad"=>"$3.35", "hot wings"=>"$3.55", "mozzarella sticks"=>"$4.20", "sampler plate"=>"$5.80"}
    end

    it "formats the @solutions display to provide the count and item" do 
      solutions = example.find_orders(example.menu_hash, "15.05")
      results = example.format_results(solutions)
      expect(results).to eq [[[7, "mixed fruit"]], [[2, "hot wings"], [1, "mixed fruit"], [1, "sampler plate"]]]
    end

    it "formats the solutions to count the unique items" do 
      solutions = [["mixed fruit", "mixed fruit", "mixed fruit"]]
      results = example.format_results(solutions)
      expect(results).to eq [[[3, "mixed fruit"]]]
    end

    it "formats the @solutions display to list the count first" do 
      solutions = example.find_orders(example.menu_hash, "15.05")
      results = example.format_results(solutions)
      expect(results[0][0][0]).to eq 7
    end

    it "formats the @solutions display to list the item seconde" do 
      solutions = example.find_orders(example.menu_hash, "15.05")
      results = example.format_results(solutions)
      expect(results[0][0][1]).to eq "mixed fruit"
    end
  end

end