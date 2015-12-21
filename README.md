######Solution to Table XI Coding Challenge: Menu Item Combinations

Thanks for taking the time to look at my solution. If you have any questions, please feel free to reach out.

My initial solution required the user to create a properly formatted list for the code to load and analyze. My updated answer allows you to add and remove items from your list, and even update the target spending amount all from the command line. This would allow a user to theoretically walk into a restaurant and utilize the logic of the model, without having to figure out how to properly format the list file.

The controller logic behind the command line interaction of the user is housed in the controller class (located in controller.rb). The logic required to process the list, and identify how many of each item must be purchased is housed in the list and item classes (located in model.rb). The view controls all output to the screen and is located in view.rb.

Information is stored in a CSV file: 'list_holder.txt'. CSV was chosen as it is simple, practical and appropriate for the scale of this problem. In the future, to theoretically scale this approach, a database could be added or the solution could be migrated to a framework.

Choosing a CSV to store the data has another benefit: both provided lists (like menu.txt) and lists created by users (through the command line) have a nearly identical format, and can therefore be run through the same analysis process in the model. This simplifies the model and makes it more adaptable.


######Usage Instructions:

The program can be run from the command line using ARGV. There are a few basic commands:

```ruby controller.rb add```
This allows users to add items to their list. User will be prompted to enter the name and price of the item.

```ruby controller.rb solve```
This processes the list to match a user-provided target price.

```ruby controller.rb clear```
This empties the contents of the user's list.

```ruby controller.rb load```
This allows a user to load and solve a pre-made list, like the provided 'menu.txt'.
