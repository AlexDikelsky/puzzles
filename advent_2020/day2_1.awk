# run with 
# $ sed -e 's/[-:]/ /g' day_2_input_file.txt | awk -f day2_1.awk | wc -l
{ 
	num_matching = gsub($3, $3, $4);
	lower_bound = $1;
	upper_bound = $2;
	if (lower_bound <= num_matching && num_matching <= upper_bound) {
	    print($0)
	}
}
