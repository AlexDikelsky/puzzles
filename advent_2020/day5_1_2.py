f = open("day5_input.txt", "r")

max_elemnt = 0
seats = []
for line in f:
    row = int("".join(["0" if x == "F" else "1" if x == "B" else 1/0 for x in line[0:7]]), base=2)
    col = int("".join(["0" if x == "L" else "1" if x == "R" else 1/0 for x in line[7:10]]), base=2)
    identifier = row * 8 + col
    if identifier > max_elemnt: max_elemnt = identifier
    seats.append(identifier)

print(max_elemnt)
seats.sort()
for i in range(len(seats)-1):
    if seats[i+1] != seats[i]+1:
        print(seats[i])

