use std::fs;
use regex::Regex;
use std::collections::HashSet;
use std::collections::HashMap;

fn main() {
    // let file_in = fs::read_to_string("b.txt").unwrap();
    let file_in = fs::read_to_string("day7_in.txt").unwrap();

    let number_name = Regex::new(r"(\d+) ([A-z]+ [A-z]+) bags?.?").unwrap();
    let name_only = Regex::new("([A-z]+ [A-z]+) bags?").unwrap();

    let inputs: HashMap<String, Vec<(String, usize)>> = file_in
        .lines()
        .map(|line| {
            let split: Vec<&str> = line.split(" contain ").collect();
            let container_name = name_only.captures(split[0]).unwrap()[1].to_string();
            let contents_names = if split[1] != "no other bags." {
                split[1]
                    .split(", ")
                    .map(|group| {
                        let matched_name = number_name.captures(group).unwrap();
                        (
                            matched_name[2].to_string(),
                            matched_name[1].parse().unwrap(),
                        )
                    })
                    .collect()
            } else {
                vec![]
            };
            (container_name, contents_names)
        })
        .collect();

    // dbg!(&inputs);
    dbg!(part2("shiny gold", &inputs) - 1);
}

fn part2(search_for: &str, map: &HashMap<String, Vec<(String, usize)>>) -> usize {
    map[search_for].iter().fold(1, |acc, bag| {
        acc + bag.1 * part2(&bag.0, map)
    })
}
