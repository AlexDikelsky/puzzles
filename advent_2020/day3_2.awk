# Make an array with carefully chosen values
# The first value corresponds to how far down to go,
# and the second tells how far to go on the line
BEGIN { xs[11] = xs[13] = xs[15] = xs[17] = xs[21] = 0 }
{
    for (x in xs) {
	if ((NR-1) % (int(x/10)) == 0) {
	    slope = (x % 10) / int(x/10);
	    i = ((NR-1) * slope) % length($0);
	    xs[x] += substr($0, i + 1, 1) == "#";
	}
    }
}
END { for(x in xs) { print x, xs[x] } }
