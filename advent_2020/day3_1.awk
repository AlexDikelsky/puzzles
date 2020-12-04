BEGIN { xs[13] = 0; }
{
    for (x in xs) {
	if ((NR-1) % (int(x/10)) == 0) {
	    i = ((NR-1) * (x % 10)) % length($0);
	    if (substr($0, i + 1, 1) == "#") {
		xs[x] += 1;
	    }
	}
    }
}
END { print xs[13]; }



