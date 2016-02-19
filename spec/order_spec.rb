require_relative '../order'


RSpec.describe Order do

  let (:order) { Order.new }

  describe "#instructions" do
    xit "messages instructions for the program" do 
    end 
  end

  describe "#load_file" do 
    xit "loads the menu file" do 
    end
  end

  describe "#parse" do 
    it "reads the file given and returns an array of each line of text" do 
      menu1 = order.parse("menu.txt")
      expect(menu1[0]).to eq "$15.05"
    end
  end

  describe "@message_results" do 
  end

end