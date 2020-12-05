BEGIN { 
    strs["byr"] = 0;
    strs["iyr"] = 0;
    strs["eyr"] = 0;
    strs["hgt"] = 0;
    strs["hcl"] = 0;
    strs["ecl"] = 0;
    strs["pid"] = 0;
    strs["cid"] = 0; 
}


length($0) == 0 { 
    years_valid = ( \
      (records["byr"] >= 1920 && records["byr"] <= 2002) && \
      (records["iyr"] >= 2010 && records["iyr"] <= 2020) && \
      (records["eyr"] >= 2020 && records["eyr"] <= 2030));

    # if (years_valid) { print records["byr"],records["iyr"],records["eyr"] };

    sdf = records["hgt"];
    if(gsub(/cm$/, "", records["hgt"]) == 1) {
	height_valid = (records["hgt"] >= 150 && records["hgt"] <= 193);
    } else {
	if(gsub(/in$/, "", records["hgt"]) == 1) {
	    height_valid = (records["hgt"] >= 59 && records["hgt"] <= 76);
	} else {
	    height_valid = 0;
	    print records["hgt"];
	}
    }
    # if (height_valid) { print sdf, records["hgt"]; }

    hair_valid = gsub(/^#[0-9a-f]{6}$/, records["hcl"], records["hcl"]);
    # if (hair_valid) { print records["hcl"]; }

    eye_valid = gsub(/^(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)$/, 
	      records["ecl"], records["ecl"]);
    # if (eye_valid) { print records["ecl"]; }

    pid_valid = length(records["pid"]) == 9;
    # if (pid_valid) { print records["pid"]; }

    valid = years_valid && height_valid && hair_valid && eye_valid && pid_valid;
    # if (valid) { print "Valid"; }
        

    # if (failed == 1) { print "Failed", NR; }
    # if (failed == 0) { print length(records), NR; }
    for(record in records) {
	# print record, records[record]
	delete records[record];
    }
}
length($0) != 0 {
    for(j=1; j<=NF; j += 1) {
	records[substr($j, 1, 3)] = substr($j, 5);
    }
}
