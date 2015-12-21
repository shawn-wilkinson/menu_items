class Item

    attr_reader :name, :price

    def initialize(name,price)
        @name, @price = name, price.to_f
    end

end

class List

    attr_reader :solved

    def initialize(file_name, target_price = nil)
        @target_price = target_price.delete('$').to_f if target_price
        @file = File.open(file_name)
        @items = []
        @item_count = Hash.new
        @solved = false
        setup_list
        process_list
    end

    def setup_list
        @file.each do |line|
            lines = line.chomp.split(',')
            if @target_price == nil
                @target_price = lines.first.delete('$').to_f
            else
                @item_count[lines[0]] = 0
                @items << Item.new(lines[0],lines[1].delete('$'))
            end
        end
        @items = @items.sort_by{|item| item.price}.reverse
    end

    def process_list
        if !item_prices_too_high? && find_combination(@items,@target_price)
            @solved = true
        end
    end

    def find_combination(item_array, remainder)
        current_item = item_array.first
        if evenly_divisible?(remainder,current_item.price)
             @item_count[current_item.name] = (remainder / current_item.price).to_i
            return true
        end
        return false if item_array.length == 1
        n = (remainder / current_item.price).to_i
        while n >= 0
            new_remainder = remainder - (n * current_item.price)
            if find_combination(item_array[1..-1],new_remainder)
                @item_count[current_item.name] = n
                return true
            end
            n = n - 1
        end
        return false
    end

    def return_result
        if @solved
            include_item_prices_in_item_count
            return @target_price, @item_count
        else
            return @target_price
        end
    end

    def include_item_prices_in_item_count
        @item_count.each do |name, qty|
            if qty > 0
                @item_count[name] = [qty, price_lookup(name)]
            else
                @item_count.delete(name)
            end
        end
    end

    def item_prices_too_high?
        @items.all?{|item| item.price > @target_price}
    end

    def evenly_divisible?(large,small)
        (large.to_f / small.to_f).round(4) % 1 == 0
    end

    def price_lookup(input_name)
        @items.find{|item| item.name == input_name}.price
    end

end
