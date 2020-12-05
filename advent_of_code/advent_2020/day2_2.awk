# run with 
# $ sed -e 's/[-:]/ /g' day_2_input_file.txt | awk -f day2_2.awk | wc -l
{ 
	first_index = $1;
	other_index = $2;
	if ((substr($4, first_index, 1) == $3) + (substr($4, other_index, 1) == $3) == 1) {
	    print($0);
	}
}
