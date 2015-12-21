class View

  def initialize
  end

  def delete_confirmation
    puts "Are you sure you want to delete the list? This cannot be undone."
  end

  def file_deleted
    puts "File has been deleted."
  end

  def file_not_deleted
    puts "File has not been deleted."
  end

  def get_item
    puts "What is the name of the item you would like to add?"
  end

  def get_price
    puts "What is the price?"
  end

  def get_budget
    puts "What is your budget?"
  end

  def get_list_file
    puts "Which list would you like to load?"
  end

  def invalid_list
    puts "The list you specified could not be loaded."
  end

  def invalid_entry
    puts "Invalid Entry. Valid Commands are 'Add', 'Solve', 'Clear' and 'Load'."
  end

  def display_result(target_price,item_count)
    puts "To spend a total of $#{sprintf('%.2f', target_price)}, buy the following:"
    item_count.each do |name, info|
        puts "#{info.first} #{name} at $#{sprintf('%.2f', info.last)} each"
    end
  end

  def no_result_found(target_price)
    puts "There is no possible combination to reach a total of $#{sprintf('%.2f', target_price)}"
  end

end