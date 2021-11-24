io = open("data.txt", "r")
data = split(read(io, String), '\n')[begin: end-1]

count_chars(a, c) = begin
    a[Int(c) - Int('a') + 1] += 1
    a
end

count_nums(d, c) = begin
    if get(d, c, "not-found") == "not-found"
        d[c] = 1
        d
    else
        d[c] += 1
        d
    end
end

counts_by(f, x, init=Dict()) = reduce(f, x, init=init)

base_alpha = collect(map(_->0, 1:26))

count_2_and_3(s) = begin
    row = counts_by(
      count_nums, 
      counts_by(
          count_chars, 
          s, 
          deepcopy(base_alpha)))
    [get(row, 2, "nf") != "nf", get(row, 3, "nf") != "nf"]
end

z(d) = map(count_2_and_3, d)
p1_ans = reduce(*, foldr(+, z(data)))

same_letters(s, t) = mapreduce(x -> x[1] == x[2], +, zip(s, t))
same_but_neq(s, t) = s == t ? 0 : same_letters(s, t)

result = maximum(map(x -> (same_but_neq(x[1], x[2]), x[1], x[2]), 
                     Iterators.product(data, data)))

p2_ans = join(map(x -> x[1], 
                  collect(Iterators.filter((==), zip(result[2], result[3])))))
