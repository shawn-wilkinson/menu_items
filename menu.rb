class Item
    attr_reader :name, :price

    def initialize(name,price)
        @name, @price = name, price.to_f
    end
end

class List

    def initialize(file_name)
        @total_price = nil
        @file = File.open(file_name)
        @items = []
        @item_count = Hash.new
        setup_list
        if find_mix(@items,@total_price)
            output_result
        else
            output_no_result_found
        end
    end

    def setup_list
        @file.each do |line|
            lines = line.chomp.split(',')
            if @total_price == nil
                @total_price = lines.first.delete('$').to_f
            else
                @item_count[lines[0]] = 0
                @items << Item.new(lines[0],lines[1].delete('$'))
            end
        end
        @items = @items.sort_by{|item| item.price}.reverse
    end

    def find_mix(item_array, remainder)
        current_item= item_array.first
        return false if @items.last.price > @total_price
        if evenly_divisible?(remainder,current_item.price)
             @item_count[current_item.name] += (remainder / current_item.price).to_i
            return true
        end
        return false if item_array.length == 1
        n = (remainder / current_item.price).to_i
        while n >= 0
            new_remainder = remainder - (n * current_item.price)
            if find_mix(item_array[1..-1],new_remainder)
                @item_count[current_item.name] = n
                return true
            end
            n = n - 1
        end
        return false
    end

    def output_result
        puts "To spend a total of $#{sprintf('%.2f', @total_price)}, buy the following:"
        @item_count.each do |name, qty|
            puts "#{qty} #{name} at $#{sprintf('%.2f', price_lookup(name))} each" if qty > 0
        end
    end

    def output_no_result_found
        puts "There is no possible combination to reach a total of $#{@total_price}"
    end

    def evenly_divisible?(large,small)
        # (((large.to_f / small.to_f) * 100).round / 100.00) % 1 == 0
        (large.to_f / small.to_f).round(4) % 1 == 0
    end

    def price_lookup(input_name)
        @items.find{|item| item.name == input_name}.price
    end




end

new_list = List.new('menu.txt')