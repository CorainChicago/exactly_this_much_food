require_relative '../menu'

RSpec.describe Menu do

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

  let (:menu) { Menu.new }

  describe "#get_target_price" do 
    it "takes the first item from the menu_array" do
      menu.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      goal = menu.get_target_price
      expect(goal).to eq  "15.05"
    end 
  end

  describe "#convert_array_to_hash" do 

    before do  
      menu.menu_array = ["$15.05", "mixed fruit,$2.15", "french fries,$2.75", "side salad,$3.35", "hot wings,$3.55", "mozzarella sticks,$4.20", "sampler plate,$5.80"]
      menu.get_target_price
      menu.convert_array_to_hash
    end

    it "converts the array into a hash" do
      expect(menu.menu_hash).to be_a(Hash)
    end

    it "produces a hash with the item as key and price as value" do
      expect(menu.menu_hash["mixed fruit"]).to eq "$2.15"
    end
  end


end