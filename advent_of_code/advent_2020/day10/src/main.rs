use std::fs;
use std::cmp::Ordering::{Less, Equal, Greater};
use cached::proc_macro::cached;

fn main() {

    // let file_in = fs::read_to_string("a.txt").unwrap();
    // let file_in = fs::read_to_string("b.txt").unwrap();
    let file_in = fs::read_to_string("day10_in.txt").unwrap();

    let mut input: Vec<usize> = file_in.lines().map(|x| x.parse().unwrap()).collect();

    input.sort();

    dbg!(part1(0, &input));
    dbg!(part2(0, input.clone(), *input.last().unwrap()));
}

#[cached]
fn part2(initial: usize, rest: Vec<usize>, goal: usize) -> usize {
    match initial.cmp(&goal) {
        Less => rest.iter().take(3).zip(1..4).map(|(jolts, n)| {
            if jolts - initial < 4 {
                part2(*jolts, rest[n..].to_vec(), goal)
            } else {
                0
            }
        }).sum(),
        Equal => 1,
        Greater => 0,
    }
}

fn part1(start: usize, input: &[usize]) -> (usize, usize, usize) {
    let (a, b, c) = input.windows(2).fold((0, 0, 0), |state, window| {
        let (ones, twos, threes) = state;
        match window[1] - window[0] {
            1 => (ones + 1, twos, threes),
            2 => (ones, twos + 1, threes),
            3 => (ones, twos, threes + 1),
            a => panic!("Found a {} with {}, {}", a, window[0], window[1])
        }
    });
    match input[0] - start {
        1 => (a + 1, b, c + 1),
        2 => (a, b + 1, c + 1),
        3 => (a, b, c + 1 + 1),
        d => panic!("Bad input {}", d),
    }
}
