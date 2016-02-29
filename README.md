# Exactly This Much Food

A command line program to return orders from a menu file which exactly match the target price. 

## Instructions

* [Clone](https://help.github.com/articles/cloning-a-repository/) this repository to your computer.
* Add the text file(s) into the menus folder. There is already an example file in the folder ('menus/test.txt').  The target price needs to be on the first line on the file and menu item should follow.  The menu items need to follow this format of "item, $price", for example "french fries, $2.50".  

      Here is an example text file:
      ```text
      $15.05
      mixed fruit, $2.15
      french fries,$2.75
      side salad,$3.35
      hot wings,$3.55
      mozzarella sticks,$4.20
      sampler plate,$5.80
      ```

* Open a terminal window and navigate to the location of the cloned files on your computer.
* Type `ruby runner.rb` to run the program.


If you want to change the target price for your order, please update the number in your file, save the file and then restart the program with `ruby runner.rb`.    





