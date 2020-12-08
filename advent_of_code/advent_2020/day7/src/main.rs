use std::fs;
use regex::Regex;
use std::collections::HashSet;
use std::collections::HashMap;

fn main() {
    //let file_in = fs::read_to_string("c.txt").unwrap();
    let file_in = fs::read_to_string("day7_in.txt").unwrap();

    let number_name = Regex::new(r"(\d+) ([A-z]+ [A-z]+) bags?").unwrap();
    let name_only = Regex::new("([A-z]+ [A-z]+) bags?").unwrap();

    for _ in 0..1 {
        for line in file_in.lines() {
            let s: Vec<&str> = line.split(" contain ").collect();
            assert!(s.len() == 2);
            let container = name_only.captures_iter(s[0]).next().unwrap()[1].to_string();
            let contents: Vec<&str> = s[1].strip_suffix(".").unwrap().split(", ").collect();

            for bag_name_with_extra in contents.iter() {
                // dbg!(&bag_name_with_extra);
                match bag_name_with_extra == &"no other bags" {
                    true  => (),
                    false => {
                        let bag_name = 
                            &number_name.captures_iter(bag_name_with_extra).next().unwrap()[2];
                        // dbg!(&bag_name);
                        if contain_golden.contains(bag_name) {
                            // dbg!(&bag_name);
                            contain_golden.insert(container.clone());
                        };
                    }
                };
            };
        };
        before_len = after_len;
        after_len = contain_golden.len();
    }
    dbg!(&contain_golden, after_len - 1);
}
