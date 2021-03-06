#[macro_use]
extern crate lazy_static;
use std::fs;
use regex::Regex;
use std::iter;

fn main() {
    let contents = fs::read_to_string("day5_in.txt").unwrap();

    let mut p1_counter = 0;
    let mut p2_counter = 0;
    for line in contents.lines() {
        if part1_valid(line) {
            p1_counter += 1;
        }
        if part2_valid(line) {
            p2_counter += 1;
        }
    }
    println!("Part 1: {}\nPart 2: {}", p1_counter, p2_counter);
}

fn part1_valid(s: &str) -> bool {
    lazy_static!{
        static ref REGEX_FOR_BAD: regex::Regex = Regex::new("(ab)|(cd)|(pq)|(xy)").unwrap();
    };

    let ((_, vowels), (doubles, bad)) = s.chars().fold((('.', 0), (false, false)), |state, x| {
        let ((prev_char, vowels_found), (doubles, bad)) = state;
        let both = prev_char.to_string() + &x.to_string();

        (
            (
                x,
                if "aeiou".contains(x) {
                    1 + vowels_found
                } else {
                    vowels_found
                },
            ),
            (
                doubles || (prev_char == x),
                bad || REGEX_FOR_BAD.is_match(&both),
            ),
        )
    });

    (vowels >= 3) && doubles && !bad
}

fn part2_valid(s: &str) -> bool {
    let (_, between, values) = s.chars().fold((('.', ',', 0), false, vec![]), |state, c| {
        let ((prev_prev, prev, index), between_found, out_list) = state;
        (
            (prev, c, index + 1),
            between_found || (prev_prev == c),
            out_list
                .into_iter()
                .chain(iter::once((prev, c, index)))
                .collect(),
        )
    });

    between &&
        values.iter().any(|element| {
            let (a, b, c) = element;
            values.iter().any(|x| {
                *c != 0 && x.0 == *a && x.1 == *b && x.2 != *c && x.2 != *c + 1 && x.2 != *c - 1
            }) 
        }) 

}
