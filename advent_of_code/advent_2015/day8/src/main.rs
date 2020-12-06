use std::fs;
use regex::Regex;

fn main() {
    let contents = fs::read_to_string("a.txt").unwrap();

    let backslash_quote = "\\\"";

    let specific_chars = Regex::new("^\"(\\\\\\\\|\\\\x\\d\\d|\\\\\"|.)\"$").unwrap();
    // let specific_chars = Regex::new("^\"(\\\\\\\\|\\\\x\\d\\d|\\\\\"|.)*\"$").unwrap();


    // assert!(specific_chars.is_match("\"a\""));
    // assert!(specific_chars.is_match("\"\\\\\""));
    // assert!(specific_chars.is_match("\"\\\\\\\\a\""));

    // let no_whitespace: String = contents
    //     .chars()
    //     .filter(|x| !"\n\t \r".contains(*x))
    //     .collect();

    // let total_num_chars = no_whitespace.len();

    // dbg!(specific_chars.is_match(&contents));
    for line in contents.lines() {
        println!("{}", &line);
        dbg!(specific_chars.is_match(&line));
        for cap in specific_chars.find_iter(&line) {
            dbg!(&cap);
        }
    }

    // dbg!(total_num_chars, only_in_mem_chars);

}


// #!/bin/bash
//
// # subtract twice wc -l because "s are counted in the second part when
// # they shouldn't be
// # echo $(wc -c $0) - 2 * $(wc -l $0) | sed 's/[^0-9 -]//g' | bc
// # grep -o '(\\\\)|(x\d\d)|(\\")|(.)'
// egrep -o '^"(\\\\|\x\d\d|\\"|.)*"' $0 | wc -l
