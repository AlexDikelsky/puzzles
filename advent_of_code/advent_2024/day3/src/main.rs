use regex::Regex;
use std::fs;

use crate::V::*;

fn main() {
    let file_in = fs::read_to_string("data2.txt").unwrap();
    let parsed: String = file_in.to_string();

    p1(&parsed);
    p2(&parsed);
}

fn p1(parsed: &String) {
    let m = Regex::new(r"mul\((\d{1,3}),(\d{1,3})\)").unwrap();
    let z: Vec<(isize, isize)> = m
        .captures_iter(&parsed)
        .map(|m| m.extract::<2>())
        .map(|(_, l)| {
            (
                l[0].parse::<isize>().unwrap(),
                l[1].parse::<isize>().unwrap(),
            )
        })
        .collect();
    dbg!(z.iter().map(|(a, b)| a * b).sum::<isize>());
}

#[derive(Debug, Copy, Clone,PartialEq)]
enum V {
    Mul(isize, isize),
    Do,
    Dont,
}

fn p2(parsed: &String) {
    let m = Regex::new(r"don't|do|mul\(\d{1,3},\d{1,3}\)").unwrap();
    let mul_group = Regex::new(r"mul\((\d{1,3}),(\d{1,3})\)").unwrap();

    let z: Vec<V> = m
        .find_iter(&parsed)
        .map(|m| m.as_str())
        .map(|s| {
            match (
                s.starts_with("don't"),
                s.starts_with("do"),
                s.starts_with("mul"),
            ) {
                (true, _, _) => Dont,
                (_, true, _) => Do,
                (_, _, true) => mulp(s),
                (false, false, false) => panic!("Failed! :( :( :()))"),
            }
        })
        .collect();

    let asd = z.into_iter().fold((0, Do), |acc, x| match (acc, x) {
        (a, Do) => (a.0, Do),
        (a, Dont) => (a.0, Dont),
        (a, Mul(p, q)) => (if a.1 == Do { (acc.0 + (p*q))} else {a.0}, acc.1),
    });
    dbg!(asd);

}

fn mulp(s: &str) -> V {
    let m = Regex::new(r"mul\((\d{1,3}),(\d{1,3})\)").unwrap();
    let z = m.captures(s).unwrap().extract::<2>().1;

    Mul(
        z[0].parse::<isize>().unwrap(),
        z[1].parse::<isize>().unwrap(),
    )
}
