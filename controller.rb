require 'csv'
require "./model"
require "./view"

class Controller

  def initialize(file)
    @file = file
    @view = View.new
    @placeholder_list = nil
  end

  def clear_list
    @view.delete_confirmation
    input = STDIN.gets.chomp.downcase
    if input == 'yes' || input == 'y'
      CSV.open(@file,'w')
      @view.file_deleted
    else
      @view.file_not_deleted
    end
  end

  def add_item
    @view.get_item
    name = STDIN.gets.chomp
    @view.get_price
    price = STDIN.gets.chomp
    CSV.open(@file, 'a+')  do |list|
      list << [name, price]
    end
  end

  def process_list
    @view.get_budget
    target_price = STDIN.gets.chomp
    @placeholder_list = List.new(@file,target_price)
    output_result
  end

  def process_existing_list
    @view.get_list_file
    new_file = STDIN.gets.chomp

    if File.exist?(new_file)
      @placeholder_list = List.new(new_file)
      output_result
    else
      @view.invalid_list
    end
  end

  def output_result
    if @placeholder_list.solved
      target_price, item_count_hash = @placeholder_list.return_result
      @view.display_result(target_price, item_count_hash)
    else
      target_price = @placeholder_list.return_result
      @view.no_result_found(target_price)
    end
  end

  def invalid_entry
    @view.invalid_entry
  end

end

list_controller = Controller.new("list_holder.txt")

if ARGV.length > 0
  input = ARGV.map!{|ele| ele.downcase}
  if input[0] == 'clear'
    list_controller.clear_list
  elsif ARGV[0] == 'add'
    list_controller.add_item
  elsif ARGV[0] == 'solve'
    list_controller.process_list
  elsif ARGV[0] == "load"
    list_controller.process_existing_list
  else
    list_controller.invalid_entry
  end
end



