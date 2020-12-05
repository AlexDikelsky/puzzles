use std::fs;
use std::collections::HashSet;
use std::iter;

fn main() {
    part1();
    part2();
}

#[allow(unused)]
fn part1() {
    let contents = fs::read_to_string("day3_in.txt").unwrap();

    let mut state = (0, 0);
    println!("{}", contents.trim().chars().map(|direction| match direction {
        'v' => { let (lr, ud) = state; state = (lr, ud - 1); state },
        '^' => { let (lr, ud) = state; state = (lr, ud + 1); state },
        '>' => { let (lr, ud) = state; state = (lr + 1, ud); state },
        '<' => { let (lr, ud) = state; state = (lr - 1, ud); state },
        a => panic!("Unexpected {}", a),
    }).chain(iter::once((0,0))).collect::<HashSet<(isize, isize)>>().len());
}

#[allow(unused)]
fn part2() {
    let contents = fs::read_to_string("day3_in.txt").unwrap();

    let mut state = (0, 0);
    let mut robo_state = (0, 0);
    println!("{}", contents.trim().chars().zip(0..).map(|(direction, to_move)| {
        let state_here = if to_move % 2 == 0 {
            state
        } else {
            robo_state
        };

        let new_state = match direction {
            'v' => { let (lr, ud) = state_here; (lr, ud - 1)},
            '^' => { let (lr, ud) = state_here; (lr, ud + 1)},
            '>' => { let (lr, ud) = state_here; (lr + 1, ud)},
            '<' => { let (lr, ud) = state_here; (lr - 1, ud)},
            a => panic!("Unexpected {}", a),
        };

        if to_move % 2 == 0 {
            state = new_state;
        } else {
            robo_state = new_state;
        };
        new_state
    }).chain(iter::once((0,0))).collect::<HashSet<(isize, isize)>>().len());
}
