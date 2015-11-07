def find_mix(number_array,remainder)
    current_number = number_array.first
    if remainder % current_number == 0
        p "#{current_number} divides evenly for #{remainder}"
        return true
    end
    return false if number_array.length == 1
    n = remainder / current_number
    while n >= 0
        new_remainder = remainder - (n * current_number)
        if find_mix(number_array[1..-1],new_remainder)
            p "#{current_number}, #{n} times"
            p "#{remainder} is left..."
            return true
        end
        n = n - 1
    end
    return false
end

find_mix([8,4,2,1],17)

