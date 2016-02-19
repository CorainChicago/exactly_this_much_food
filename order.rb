class Order
  attr_accessor :menu_array, :total

  def initialize
    @menu_array = []
    total = nil
  end

  def instructions
    p "Please enter the file you want to upload"
  end

  def parse(filename)
    File.readlines(filename).each do |line|
     @menu_array << line.chop
    end
  end

  def get_total
    total = @menu_array[0]
  end

end


