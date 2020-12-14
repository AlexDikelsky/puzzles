use std::fs;
use Cardinal::{North, South, East, West};

mod tests;

type State = (Cardinal, isize, isize);

type Point = (isize, isize);

type StatePart2 = (Point, Point);

const INITIAL_STATE: State = (East, 0, 0);
const INITIAL_STATE_PART_TWO: StatePart2 = ((10, 1), (0, 0));


#[derive(Debug, Copy, Clone)]
enum Cardinal {
    North,
    East,
    South,
    West,
}

#[derive(Debug, Copy, Clone)]
enum Instruction {
    North,
    East,
    South,
    West,
    Left,
    Right,
    Forward,
}


fn main() {
    let file_in = fs::read_to_string("a.txt").unwrap();
    // let file_in = fs::read_to_string("b.txt").unwrap();
    // let file_in = fs::read_to_string("day12_in.txt").unwrap();
    
    let parsed: Vec<(Instruction, usize)> = file_in.lines().map(|line| {
        (
            match line.chars().next().unwrap() {
                'N' => Instruction::North,
                'E' => Instruction::East,
                'W' => Instruction::West,
                'S' => Instruction::South,
                'R' => Instruction::Right,
                'L' => Instruction::Left,
                'F' => Instruction::Forward,
                a => panic!("Found an {}", a),
            },
            line.chars().skip(1).collect::<String>().parse().unwrap()
        )
    }).collect();

    // dbg!(step(INITIAL_STATE, &parsed));
    dbg!(step(INITIAL_STATE, &parsed));
    dbg!(part2_step(INITIAL_STATE_PART_TWO, &parsed));

}

fn part2_step(state: StatePart2, directions: &[(Instruction, usize)]) -> StatePart2 {
    if directions.is_empty() {
        state
    } else {
        let ((w_x, w_y), _) = state;
        let (waypoint, ship) = state;
        let (instruction, distance) = directions[0];
        let distance = distance as isize;
        let new_state = match instruction {
            Instruction::North => ((w_x, w_y + distance), ship),
            Instruction::South => ((w_x, w_y - distance), ship),
            Instruction::East  => ((w_x + distance, w_y), ship),
            Instruction::West  => ((w_x - distance, w_y), ship),
            Instruction::Left  => (rotate_counterclockwise(distance, waypoint, ship), ship),
            Instruction::Right => (rotate_clockwise(distance, waypoint, ship), ship),
            Instruction::Forward => forward(waypoint, ship, distance),
        };
        dbg!(new_state);
        part2_step(new_state, &directions[1..])
    }
}

fn forward(waypoint: Point, ship: Point, distance: isize) -> StatePart2 {
    let (w_x, w_y) = waypoint;
    let (s_x, s_y) = ship;
    let f = |a, b| {
        (a + ((w_x - s_x) * distance), b + ((w_y - s_y) * distance))
    };
    (f(w_x, w_y), f(s_x, s_y))
}
    



pub fn rotate_clockwise(deg: isize, wrt_about: Point, about: Point) -> Point {
    rotate_counterclockwise(-deg, wrt_about, about)
}

pub fn rotate_counterclockwise(deg: isize, wrt_about: Point, about: Point) -> Point {
    let wrt_center = (wrt_about.0 - about.0, wrt_about.1 - about.1);
    let (x_t, y_t) = matrix_rotate(wrt_center, deg);
    (x_t + about.0, y_t + about.1)
}

pub fn matrix_rotate(point_wrt_center: Point, deg: isize) -> Point {
    let (x, y) = point_wrt_center;
    (x * i_cos(deg) + y * (-i_sin(deg)),
     x * i_sin(deg) + y * i_cos(deg))
}
     

fn i_sin(n: isize) -> isize {
    match n {
        -270 => 1,
        -180 => 0,
        -90  => -1,
        90   => 1,
        180  => 0,
        270  => -1,
        a => panic!("Sin of {}", a),
    }
}

fn i_cos(n: isize) -> isize {
    match n {
        -270 => 0,
        -180 => -1,
        -90  => 0,
        90   => 0,
        180  => -1,
        270  => 0,
        a => panic!("Cos of {}", a),
    }
}
fn right(d: Cardinal) -> Cardinal {
    match d {
        North => East,
        East  => South,
        South => West,
        West  => North,
    }
}

fn left(d: Cardinal) -> Cardinal {
    match d {
        North => West,
        West  => South,
        South => East,
        East  => North,
    }
}

fn step(state: State, directions: &[(Instruction, usize)]) -> State {
    if directions.is_empty() {
        state
    } else {
        let (card, x_coord, y_coord) = state;
        let (instruction, distance) = directions[0];
        let distance = distance as isize;
        let new_state = match instruction {
            Instruction::North => (card, x_coord, y_coord + distance),
            Instruction::West  => (card, x_coord - distance, y_coord),
            Instruction::South => (card, x_coord, y_coord - distance),
            Instruction::East  => (card, x_coord + distance, y_coord),
            Instruction::Right => (match distance {
                90  => right(card),
                180 => right(right(card)),
                270 => right(right(right(card))),
                _ => panic!("Right {} degrees", distance),
            }, x_coord, y_coord),
            Instruction::Left => (match distance {
                90  => left(card),
                180 => left(left(card)),
                270 => left(left(left(card))),
                _ => panic!("Left {} degrees", distance),
            }, x_coord, y_coord),
            Instruction::Forward => (card, match card {
                East => x_coord + distance,
                West => x_coord - distance,
                _ => x_coord,
            }, match card {
                North => y_coord + distance,
                South => y_coord - distance,
                _ => y_coord
            }),
        };

        step(new_state, &directions[1..])
    }
}
