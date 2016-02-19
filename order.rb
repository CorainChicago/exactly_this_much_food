class Order

  def instructions
    p "Please enter the file you want to upload"
  end

  def parse(filename)
    menu_array = []
    File.readlines(filename).each do |line|
     menu_array << line.chop
    end
    menu_array
  end

end

