# This Messenger is unique to the user story for the app and won't really be needed in other use cases - Thus a class makes better sense. 

#reread Ruby's definition of modules

module Messenger

  def message_welcome
    puts "Welcome to Exact Order! \n\nThis app will provide options from a file which match the amount provided on the first line. To use this application, please type the name of text file you need evaluated (such as a menu) and press enter. \n \nThe text file needs to be located in the 'menus' folder and be a text file ('.txt').\n" 
  end

  def message_error_enter_file_name_again
    puts "\nThere was an error reading the file, please make sure the file name is entered correctly and in the menus folder. Type 'exit' to quit the program.\n"
  end

  def message_no_results
    puts "\nWe didn't find any possible combinations to match the amount you want to spend. You can update the file and rerun the program.\n"
  end

  def message_number_solutions_with_price(number, price)
    puts "\nYou have #{number} options which add up to the target price of $#{price}."
  end

  def message_ask_to_repeat
    puts "\n\nDo you want to search another folder? Type 'Y' or 'N'"
  end

  def message_have_a_great_meal
    puts "Have a great meal."
  end

end