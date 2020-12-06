#[macro_use]
extern crate lazy_static;
use std::fs;
use regex::Regex;

fn main() {
    part1();
    part2();
}

fn part1() {
    lazy_static!{
        static ref REGEX: Regex = Regex::new(
            r"^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)$").unwrap();
    };

    let contents = fs::read_to_string("day6_in.txt").unwrap();
    let mut arr = [[false; 1000]; 1000];
    for line in contents.lines() {
        let str_for_here = REGEX.captures_iter(line).next().unwrap();

        let op = match str_for_here[1].chars().last().unwrap() {
            'n' => on,
            'f' => off,
            'e' => flip,
            a => panic!("Invalid char {}", a),
        };

        let (f_x, f_y): (usize, usize) = (
            str_for_here[2].parse().unwrap(),
            str_for_here[3].parse().unwrap(),
        );
        let (s_x, s_y): (usize, usize) = (
            str_for_here[4].parse().unwrap(),
            str_for_here[5].parse().unwrap(),
        );

        for r in 0..1000 {
            if f_y <= r && r <= s_y {
                for c in 0..1000 {
                    if f_x <= c && c <= s_x {
                        arr[r][c] = op(arr[r][c]);
                    }
                }
            }
        }
    }

    dbg!(
        arr.iter()
            .map(|x| x.iter().map(|x| if *x { 1 } else { 0 }).sum::<usize>())
            .sum::<usize>()
    );
}

fn part2() {
    lazy_static!{
        static ref REGEX: Regex = Regex::new(
            r"^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)$").unwrap();
    };

    let contents = fs::read_to_string("day6_in.txt").unwrap();
    let mut arr = [[0; 1000]; 1000];
    for line in contents.lines() {
        let str_for_here = REGEX.captures_iter(line).next().unwrap();

        let op = match str_for_here[1].chars().last().unwrap() {
            'n' => p2on,
            'f' => p2off,
            'e' => p2flip,
            a => panic!("Invalid char {}", a),
        };

        let (f_x, f_y): (usize, usize) = (
            str_for_here[2].parse().unwrap(),
            str_for_here[3].parse().unwrap(),
        );
        let (s_x, s_y): (usize, usize) = (
            str_for_here[4].parse().unwrap(),
            str_for_here[5].parse().unwrap(),
        );

        for r in 0..1000 {
            if f_y <= r && r <= s_y {
                for c in 0..1000 {
                    if f_x <= c && c <= s_x {
                        arr[r][c] = op(arr[r][c]);
                    }
                }
            }
        }
    }

    dbg!(
        arr.iter()
            .map(|x| x.iter().sum::<usize>())
            .sum::<usize>()
    );
}

fn flip(b: bool) -> bool {
    !b
}

fn on(b: bool) -> bool {
    true
}

fn off(b: bool) -> bool {
    false
}

fn p2flip(n: usize) -> usize {
    n + 2
}

fn p2on(n: usize) -> usize {
    n + 1
}

fn p2off(n: usize) -> usize {
    match n.checked_sub(1) {
        Some(x) => x,
        None => 0,
    }
}
