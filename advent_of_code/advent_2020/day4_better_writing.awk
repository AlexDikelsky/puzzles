# When there is a blank line, check if the constraints are satisfied
# Make sure there is a blank at the end of the input file
length($0) == 0 { 

    # Check constraints on years
    years_valid = ( \
      (records["byr"] >= 1920 && records["byr"] <= 2002) && \
      (records["iyr"] >= 2010 && records["iyr"] <= 2020) && \
      (records["eyr"] >= 2020 && records["eyr"] <= 2030));

    # Make sure that the heights are in the correct format and in the
    # right bounds
    if(gsub(/cm$/, "", records["hgt"]) == 1) {
	height_valid = (records["hgt"] >= 150 && records["hgt"] <= 193);
    } else {
	if(gsub(/in$/, "", records["hgt"]) == 1) {
	    height_valid = (records["hgt"] >= 59 && records["hgt"] <= 76);
	} else {
	    height_valid = 0;
	}
    }
    # Hair and eye need to match these regexes
    hair_valid = gsub(/^#[0-9a-f]{6}$/, "", records["hcl"]);
    eye_valid = gsub(/^(amb)|(blu)|(brn)|(gry)|(grn)|(hzl)|(oth)$/, "", records["ecl"]);

    # Make sure the size of pid is right
    pid_valid = length(records["pid"]) == 9;

    valid = years_valid && height_valid && hair_valid && eye_valid && pid_valid;
    if (valid) { print "Valid"; }

    # Clear list for next run
    for(record in records) {
	delete records[record];
    }
}

# Add elements to the assocative array here
length($0) != 0 {
    for(j=1; j<=NF; j += 1) {
	records[substr($j, 1, 3)] = substr($j, 5);
    }
}
