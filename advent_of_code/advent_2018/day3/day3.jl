io = open("data.txt", "r")

find_id(k) = parse(Int, split(split(k, ' ')[1], '#')[2])
find_coords(k) = Tuple(map(x -> parse(Int, x), split(split(split(k, ' ')[3], ':')[1], ',')))
find_size(k) = Tuple(map(x -> parse(Int, x), split(split(k, ' ')[4], 'x')))

data = map(line -> (find_id(line), find_coords(line), find_size(line)), split(read(io, String), '\n')[begin: end-1])

arr = zeros(Int, (1000, 1000))

t(x, arr) = begin
    (_, (b1, b2), (c1, c2)) = x
    view(arr, (b2+1):(b2+c2), (b1+1):(b1+c1)) .+= 1
end

foreach(x -> t(x, arr), data)

p1_ans = sum(arr .> 1)

z(x, arr) = begin
    (id, (b1, b2), (c1, c2)) = x
    (sum(view(arr, (b2+1):(b2+c2), (b1+1):(b1+c1))) == (c1 * c2), id)
end

p2_ans = maximum(map(x -> z(x, arr), data))
