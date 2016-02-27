module Messenger

  def message_error_enter_file_name_again
    puts "There was an error reading the file, please make sure the file name is entered correctly and in this folder (not listed in a sub-directory)."
  end

  def message_welcome
    puts "Welcome to Exact Order! \n\nThis app will provide options from a file which match the amount provided on the first line. To use this application, please type the name of text file you need evaluated (such as a menu) and press enter. \n \nThe text file needs to be in the same folder as the application and be a text file.\n" 
  end


  
end