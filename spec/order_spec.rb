require_relative '../order'


RSpec.describe Order do

  let (:order) { Order.new }

  describe "#instructions" do
    xit "messages instructions for the program" do 
    end 
  end

  describe "#parse" do 
    it "reads the file given and returns an array of each line of text" do 
      menu = order.parse("menu.txt")
      p menu
      expect(menu[0]).to eq "$15.05"
    end
  end

  describe "#get_total" do 
    it "takes the first item from the menu_array" do
      menu = order.parse("menu.txt")
      goal = order.get_total
      expect(goal).to eq "$15.05"

    end
  end


  describe "@message_results" do 
  end

end