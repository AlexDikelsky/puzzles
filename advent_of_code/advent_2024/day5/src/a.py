[a, b] = "".join(open("data2.txt")).split("\n\n")
aa = [tuple(map(int, x.split("|"))) for x in a.split("\n")]
bb = [list(map(int, x.split(","))) for x in b.split("\n")[:-1]]

