BEGIN { 
    strs["byr"] = 0;
    strs["iyr"] = 0;
    strs["eyr"] = 0;
    strs["hgt"] = 0;
    strs["hcl"] = 0;
    strs["ecl"] = 0;
    strs["pid"] = 0;
    strs["cid"] = 0; }

length($0) == 0 { 
    # print "Len 0 at", NR;
    for(x in strs) {
	if (x != "cid" && (records[x] != 1)) {
	    failed = 1;
	    # print "failed", x
	}
    }
    # if (failed == 1) { print "Failed", NR; }
    if (failed == 0) { print length(records), NR; }
    for(record in records) {
	# print record, records[record]
	delete records[record];
    }
    failed = 0;
}
length($0) != 0 {
    for(j=1; j<=NF; j += 1) {
	records[substr($j, 1, 3)] = 1;
    }
}
