from collections import Counter

parsed = [tuple(map(int, x.split("   "))) for x in open("in.py")]
l1 = sorted([x[0] for x in parsed])
l2 = sorted([x[1] for x in parsed])
print(sum(map(lambda x,y: abs(y-x), l1, l2)))

c = Counter(l2)

print(sum(map(lambda x: (x * c[x]), l1)))
