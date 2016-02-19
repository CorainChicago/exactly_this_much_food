require_relative '../order'


RSpec.describe Order do

  let (:order) { Order.new }

  describe "attributes" do
    it "messages instructions for the program" do 
    end 
  end

  describe "#parse" do 
    it "reads the file given and returns an array of each line of text" do 
      menu = order.parse("menu.txt")
      expect(menu[0]).to eq "$15.05\n"
      expect(menu.length).to eq 7
    end
  end

  describe "#get_total" do 
    it "takes the first item from the menu_array" do
      menu = order.parse("menu.txt")
      goal = order.get_total
      expect(goal).to eq "$15.05"
    end
  end

  describe "#remove_whitespace" do 
    it "removes the extra whitespace" do 
      order.parse("menu.txt")
      order.remove_whitespace
      expect(order.menu_array[1]).to eq "mixed fruit,$2.15"
    end
  end

  describe "#convert_to_hash" do 
    it "converts the array into a hash" do
      order.parse("menu.txt")
      order.remove_whitespace
      order.get_total
      order.menu_array
      order.convert_to_hash
      expect(order.menu_hash).to be_a(Hash)
    end

    it "produces a hash with the item as key and price as value" do
      order.parse("menu.txt")
      order.remove_whitespace
      order.get_total
      order.menu_array
      order.convert_to_hash
     expect(order.menu_hash["mixed fruit"]).to eq "$2.15"
    end
  end

  describe "#add_prices" do 
    it "adds the values for the selected keys" do 
      order.parse("menu.txt")
      order.remove_whitespace
      order.get_total
      order.menu_array
      order.convert_to_hash
      expect(order.add_prices(["mixed fruit", "french fries"])).to eq 4.90
    end
  end

  describe "#possible_orders" do
    it "will return 2 order options for a specific total from the menu_hash" do
      order.parse("menu.txt")
      order.remove_whitespace
      order.get_total
      order.menu_array
      order.convert_to_hash
      result = order.possible_orders
      expect(result.length).to eq 2
    end 
  end
end