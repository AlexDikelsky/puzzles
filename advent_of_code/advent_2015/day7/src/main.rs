#[macro_use]
extern crate lazy_static;
use std::fs;
use regex::Regex;
use std::collections::HashMap;

fn main() {
    part2();
}

fn part1() -> u16 {
    let unary = Regex::new(r"^(NOT) ([A-z0-9]+) -> ([A-z]+)").unwrap();
    let binary = Regex::new(
        r"^([A-z0-9]+) (OR|AND|RSHIFT|LSHIFT) ([A-z0-9]+) -> ([A-z]+)",
    ).unwrap();
    let assign = Regex::new(r"([A-z0-9]+) -> ([A-z]+)").unwrap();
    let number = Regex::new(r"\d+").unwrap();

    let mut map: HashMap<String, u16> = HashMap::new();

    while !map.contains_key("a") {
        let contents = fs::read_to_string("day7_in.txt").unwrap();
        for line in contents.lines() {
            if unary.is_match(&line) {
                let captures: regex::Captures = unary.captures_iter(line).next().unwrap();
                let (arg, out) = (&captures[2], &captures[3]);
                if number.is_match(arg) {
                    map.insert(out.to_string(), !arg.parse::<u16>().unwrap());
                } else {
                    if map.contains_key(arg) {
                        map.insert(out.to_string(), !map[arg]);
                    }
                }
            } else if binary.is_match(&line) {
                let captures: regex::Captures = binary.captures_iter(line).next().unwrap();
                let (left_arg, right_arg, out) = (&captures[1], &captures[3], &captures[4]);
                let f = match &captures[2].chars().next().unwrap() {
                    'O' => |x, y| x | y,
                    'A' => |x, y| x & y,
                    'L' => |x, y| x << y,
                    'R' => |x, y| x >> y,
                    _ => panic!("abcdefg"),
                };
                match (number.is_match(left_arg), number.is_match(right_arg)) {
                    (true, true) => {
                        map.insert(
                            out.to_string(),
                            f(left_arg.parse().unwrap(), right_arg.parse().unwrap()),
                        );
                    }
                    (true, false) => {
                        if map.contains_key(right_arg) {
                            map.insert(
                                out.to_string(),
                                f(left_arg.parse().unwrap(), map[right_arg]),
                            );
                        }
                    }
                    (false, true ) => {
                        if map.contains_key(left_arg) {
                            map.insert(
                                out.to_string(),
                                f(map[left_arg], right_arg.parse().unwrap()),
                            );
                        }
                    }
                    (false, false) => {
                        if map.contains_key(left_arg) && map.contains_key(right_arg) {
                            map.insert(out.to_string(), f(map[left_arg], map[right_arg]));
                        }
                    }
                }
            } else if assign.is_match(&line) {
                let captures: regex::Captures = assign.captures_iter(line).next().unwrap();
                let (input, out) = (&captures[1], &captures[2]);
                if number.is_match(input) {
                    map.insert(out.to_string(), input.parse::<u16>().unwrap());
                } else {
                    if map.contains_key(input) {
                        map.insert(out.to_string(), map[input]);
                    }
                }
            } else {
                panic!("Failed on a line");
            }
        }
    }

    dbg!(map["a"]);

    map["a"]

}

fn part2() {
    let unary = Regex::new(r"^(NOT) ([A-z0-9]+) -> ([A-z]+)").unwrap();
    let binary = Regex::new(
        r"^([A-z0-9]+) (OR|AND|RSHIFT|LSHIFT) ([A-z0-9]+) -> ([A-z]+)",
    ).unwrap();
    let assign = Regex::new(r"([A-z0-9]+) -> ([A-z]+)").unwrap();
    let number = Regex::new(r"\d+").unwrap();

    let mut map: HashMap<String, u16> = HashMap::new();

    map.insert("b".to_string(), part1());

    while !map.contains_key("a") {
        let contents = fs::read_to_string("day7_in.txt").unwrap();
        for line in contents.lines() {
            if unary.is_match(&line) {
                let captures: regex::Captures = unary.captures_iter(line).next().unwrap();
                let (arg, out) = (&captures[2], &captures[3]);
                if number.is_match(arg) {
                    map.insert(out.to_string(), !arg.parse::<u16>().unwrap());
                } else {
                    if map.contains_key(arg) {
                        map.insert(out.to_string(), !map[arg]);
                    }
                }
            } else if binary.is_match(&line) {
                let captures: regex::Captures = binary.captures_iter(line).next().unwrap();
                let (left_arg, right_arg, out) = (&captures[1], &captures[3], &captures[4]);
                let f = match &captures[2].chars().next().unwrap() {
                    'O' => |x, y| x | y,
                    'A' => |x, y| x & y,
                    'L' => |x, y| x << y,
                    'R' => |x, y| x >> y,
                    _ => panic!("abcdefg"),
                };
                match (number.is_match(left_arg), number.is_match(right_arg)) {
                    (true, true) => {
                        map.insert(
                            out.to_string(),
                            f(left_arg.parse().unwrap(), right_arg.parse().unwrap()),
                        );
                    }
                    (true, false) => {
                        if map.contains_key(right_arg) {
                            map.insert(
                                out.to_string(),
                                f(left_arg.parse().unwrap(), map[right_arg]),
                            );
                        }
                    }
                    (false, true ) => {
                        if map.contains_key(left_arg) {
                            map.insert(
                                out.to_string(),
                                f(map[left_arg], right_arg.parse().unwrap()),
                            );
                        }
                    }
                    (false, false) => {
                        if map.contains_key(left_arg) && map.contains_key(right_arg) {
                            map.insert(out.to_string(), f(map[left_arg], map[right_arg]));
                        }
                    }
                }
            } else if assign.is_match(&line) {
                let captures: regex::Captures = assign.captures_iter(line).next().unwrap();
                let (input, out) = (&captures[1], &captures[2]);
                if number.is_match(input) && (out != "b") {
                    map.insert(out.to_string(), input.parse::<u16>().unwrap());
                } else {
                    if map.contains_key(input) {
                        map.insert(out.to_string(), map[input]);
                    }
                }
            } else {
                panic!("Failed on a line");
            }
        }
    }

    dbg!(map["a"]);

}
