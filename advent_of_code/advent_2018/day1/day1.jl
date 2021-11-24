io = open("data.txt", "r");
data = map(x -> parse(Int, x), 
           split(read(io, String), '\n')[begin: end - 1])

p1_ans = sum(data)

# f(x,y) x: (Dict, bool), y: int -> (Dict, bool)
f(x,y) = begin
    s, b = x
    if !b
        if get(s, y, "not-found") == "not-found"
            (merge(s, Dict(y=>y)), b)
        else
            (Dict(y=>y), true)
        end
    else
        (s, b)            
    end
end

g(x) = only(Iterators.take(
            Iterators.dropwhile(
                x -> !x[2],
                Iterators.accumulate(
                    f, 
                    Iterators.drop(
                        Iterators.accumulate(+, Iterators.cycle(x)), 
                        1), 
                    init=(Dict(), false))), 
            1))

