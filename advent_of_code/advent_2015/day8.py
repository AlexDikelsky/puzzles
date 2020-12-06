f = open("day8_in.txt", "r")

p1 = 0
p2 = 0

for line in f:
    a = len(line.strip())
    b = len(eval(line))
    c = len(line.strip().replace("\\", "\\\\").replace("\"", "\\\"")) + 2
    p1 += a - b
    p2 += c - a

print(p1)
print(p2)
