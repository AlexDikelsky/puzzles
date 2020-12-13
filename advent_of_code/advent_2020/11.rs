use std::fs;
use Location::{Empty, Occupied, Floor};
use Direction::{UpperRight, UpperLeft, LowerLeft, LowerRight,
Right, Left, Up, Down};

const VALUES: [Direction; 8] = [
    UpperRight,
    UpperLeft,
    LowerLeft,
    LowerRight,
    Up,
    Down,
    Left,
    Right,
];

#[allow(dead_code)]
#[derive(Debug, Copy, Clone, PartialEq)]
enum Location {
    Empty,
    Occupied,
    Floor,
}

#[allow(dead_code)]
#[derive(Debug, Copy, Clone, PartialEq)]
enum Direction {
    UpperRight,
    UpperLeft,
    LowerLeft,
    LowerRight,
    Up,
    Down,
    Left,
    Right,
}

fn main() {

    // let file_in = fs::read_to_string("a.txt").unwrap();
    // let file_in = fs::read_to_string("b.txt").unwrap();
    let file_in = fs::read_to_string("day11_in.txt").unwrap();

    let parsed: Vec<Vec<Location>> = file_in.lines().map(|line| {
        line.chars().map(|c| match c {
            'L' => Empty,
            '#' => Occupied,
            '.' => Floor,
            a => panic!("Found a {}", a),
        }).collect()
    }).collect();

    let mut part1 = parsed.clone();
    let mut part2 = parsed;
    let mut i = 0;
    loop {
        dbg!(count_occupied(&part1));
        part1 = part1_step(part1);
        dbg!(count_occupied(&part2));
        part2 = step_part2(part2);
        i += 1;
        if i > 3000 {
            break
        }
    }
}

#[allow(dead_code)]
fn count_occupied(vec: &Vec<Vec<Location>>) -> usize {
    vec.iter().map(|v| v.iter().map(|x| match x {
        Occupied => 1,
        _ => 0
    }).sum::<usize>()).sum()
}

#[allow(dead_code)]
fn bad_print(vec: Vec<Vec<Location>>) {
    for row in vec.iter() {
        for col in row.iter() {
            match col {
                Floor => print!("."),
                Occupied => print!("#"),
                Empty => print!("L"),
            }
        };
        println!();
    }
}

fn direction(grid: &Vec<Vec<Location>>, dir: Direction, center: (usize, usize)) -> Location {
    let f = match dir {
        UpperRight => |(col, row): (usize, usize)| {
            (col.checked_sub(1), Some(row+1))
        },
        LowerRight => |(col, row): (usize, usize)| {
            (Some(col+1), Some(row+1))
        },
        LowerLeft  => |(col, row): (usize, usize)| {
            (Some(col+1), row.checked_sub(1))
        },
        UpperLeft  => |(col, row): (usize, usize)| {
            (col.checked_sub(1), row.checked_sub(1))
        },
        Up         => |(col, row): (usize, usize)| {
            (col.checked_sub(1), Some(row))
        },
        Down       => |(col, row): (usize, usize)| {
            (Some(col+1), Some(row))
        },
        Left       => |(col, row): (usize, usize)| {
            (Some(col), row.checked_sub(1))
        },
        Right      => |(col, row): (usize, usize)| {
            (Some(col), Some(row+1))
        },
        
    };
    let un = |(a, b): (Option<usize>, Option<usize>)| -> Option<(usize, usize)> {
        match (a, b) {
            (Some(x), Some(y)) => Some((x, y)),
            _ => None
        }
    };
    
    let v: Vec<(usize, usize)> = (0..grid.len()).scan(center, |state, _| {
        let g = un(f(*state));
        match g {
            Some(a) => {
                *state = a
            },
            None => ()
        };
        g
    }).collect();
    
    let found = v.iter().find(|(col, row)| {
        match grid.get(*col) {
            Some(c) => match c.get(*row) {
                Some(e) => match e {
                    Occupied => true,
                    Empty => true,
                    Floor => false,
                },
                None => false
            },
            None => false
        }
    });
    match found {
        Some(point) => grid[point.0][point.1],
        None => Floor
    }
}

fn step_part2(grid: Vec<Vec<Location>>) -> Vec<Vec<Location>> {
    (0..grid.len()).map(|col| {
        (0..grid[0].len()).map(|row| { 
            let visible: usize = VALUES.iter().map(|dir| {
                match direction(&grid, *dir, (col, row)) {
                    Occupied => 1,
                    _ => 0,
                }
            }).sum();

            match grid[col][row] {
                Floor => Floor,
                Empty => if visible == 0 {
                    Occupied
                } else {
                    Empty
                },
                Occupied => if visible >= 5 {
                    Empty
                } else {
                    Occupied
                }
            }
        }).collect()
    }).collect()
}

#[allow(dead_code)]
fn part1_step(grid: Vec<Vec<Location>>) -> Vec<Vec<Location>> {
    (0..grid.len()).map(|col| {
        (0..grid[0].len()).map(|row| { 
            match grid[col][row] {
                Floor => Floor,
                Empty => if around(&grid, (row, col)) == 0 {
                    Occupied
                } else {
                    Empty
                },
                Occupied => if around(&grid, (row, col)) > 4 {
                    Empty
                } else {
                    Occupied
                }
            }
        }).collect()
    }).collect()
}

// This code is really bad, but technicly works
#[allow(dead_code)]
fn around(grid: &Vec<Vec<Location>>, center: (usize, usize)) -> usize {
    let (x, y) = center;
    let d = vec![];
    let g = match (y.checked_sub(1), x.checked_sub(1)) {
        (Some(row), Some(col)) => {
            let first_line = grid.get(row).unwrap_or(&d);
            let second_line = grid.get(y).unwrap_or(&d);
            let third_line = grid.get(y+1).unwrap_or(&d);
            assert!(col + 1 == x);
            vec![
                first_line.get(col), 
                first_line.get(x), 
                first_line.get(x+1),
                second_line.get(col),
                second_line.get(x),
                second_line.get(x+1),
                third_line.get(col),
                third_line.get(x),
                third_line.get(x+1),
            ]
        },

        (Some(row), None) => {
            assert!(row + 1 == y);
            let first_line = grid.get(row).unwrap_or(&d);
            let second_line = grid.get(y).unwrap_or(&d);
            let third_line = grid.get(y+1).unwrap_or(&d);
            assert!(grid[y][x+1] == second_line[x+1]);
            vec![
                first_line.get(x), 
                first_line.get(x+1),
                second_line.get(x),
                second_line.get(x+1),
                third_line.get(x),
                third_line.get(x+1),
            ]
        },

        (None, Some(col)) => {
            assert!(col + 1 == x);
            let second_line = grid.get(y).unwrap_or(&d); 
            let third_line = grid.get(y+1).unwrap_or(&d); 
            vec![
                second_line.get(col),
                second_line.get(x),
                second_line.get(x+1),
                third_line.get(col),
                third_line.get(x),
                third_line.get(x+1),
            ]
        },
        (None, None) => {
            let second_line = grid.get(y).unwrap_or(&d); 
            let third_line = grid.get(y+1).unwrap_or(&d); 
            assert!(grid[x][y] == second_line[y]);
            vec![
                second_line.get(x),
                second_line.get(x+1),
                third_line.get(x),
                third_line.get(x+1),
            ]
        },
    };

    g.iter().filter(|x| x.is_some()).map(|x| match x.unwrap() {
        Occupied => 1,
        _ => 0
    }).sum()
}
