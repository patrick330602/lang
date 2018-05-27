function ends_in_3(num)
    return num % 10 == 3
end

function is_prime(num)
    for i=(num-1), 2, -1 do
        if num % i == 0 then
            return false
        end
    end
    return true
end

function print_primes_ends_in_3(num)
    local stopper = 0
    local acc = 0
    while not (stopper == num) do
        acc = acc + 1
        if ends_in_3(acc) and is_prime(acc) then
            print(acc)
            stopper = stopper + 1
        end
    end
end

function for_loop(a,b,f)
    if a >= b then
         print("Error")
    else
        while not (a == b) do
            f(a)
            a = a + 1
        end
    end
end

function reduce(max, init, f)
    local reducer = init
    local acc = 0
    while not (acc == max) do
        acc = acc + 1
        reducer = f(reducer, acc)
    end
    return reducer
end

function factorial(num)
    if num == 0 then
        return 1
    else
        return reduce(num, 1, (function(m,n) return m*n end))
    end
end