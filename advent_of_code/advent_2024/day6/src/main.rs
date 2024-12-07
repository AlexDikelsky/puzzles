use crate::Heading::*;
use crate::Terrain::*;
use itertools::FoldWhile::{Continue, Done};
use itertools::Itertools;
use std::fs;

#[derive(Debug, Copy, Clone)]
enum Heading {
    N,
    S,
    E,
    W,
}

#[derive(Debug, Copy, Clone)]
enum Terrain {
    Empty(usize, usize),
    Wall(usize, usize),
}

type Po = (usize, usize);
type P = (Heading, Po);
type M = Vec<Vec<Terrain>>;

#[derive(Debug, Copy, Clone)]
struct D {
    north: Option<Terrain>,
    south: Option<Terrain>,
    east: Option<Terrain>,
    west: Option<Terrain>,
}

impl D {
    fn right(&self, h: Heading) -> (Heading, Option<Terrain>) {
        match h {
            N => (E, self.east),
            S => (W, self.west),
            E => (S, self.south),
            W => (N, self.north),
        }
    }
    fn forward(&self, h: Heading) -> (Heading, Option<Terrain>) {
        match h {
            N => (N, self.north),
            S => (S, self.south),
            E => (E, self.east),
            W => (W, self.west),
        }
    }
}

fn main() {
    let file_in = fs::read_to_string("data.txt").unwrap();
    let mut person = (0, 0);
    let m: Vec<Vec<Terrain>> = file_in
        .lines()
        .zip(0..)
        .map(|(line, row)| {
            line.chars()
                .zip(0..)
                .map(|(c, col)| match c {
                    '.' => Empty(row, col),
                    '#' => Wall(row, col),
                    '^' => {
                        person = (row, col);
                        Empty(row, col)
                    }
                    _ => panic!("parse error ☹️"),
                })
                .collect_vec()
        })
        .collect_vec();
    let person = (N, person);

    dbg!(surr(&m, (N, (0, 0))));
    // dbg!(surr(&m, (N, (3, 0))));
    // dbg!(surr(&m, (N, (1, 1))));
    // dbg!(next(&m, (E, (3, 0))));
    // dbg!(next(&m, (W, (0, 0))));

    // dbg!(person);

    let z = (0..).fold_while(person, |acc, _| {
       dbg!(&acc);
       match next(&m, acc) {
          None => Done(acc),
          Some((_, None)) => Done(acc),
          Some((_, Some(Wall(_, _)))) => panic!("Ran through wall"),
          Some((heading, Some(Empty(ny, nx)))) => Continue((heading, (ny, nx))),
       }
    }).into_inner();
    
}

fn surr(m: &M, p: P) -> D {
    let (_, (x, y)) = p;
    D {
        north: y
            .checked_sub(1)
            .map(|nn| m.get(nn).map(|a| a.get(x)))
            .flatten()
            .flatten()
            .copied(),
        south: m.get(y + 1).map(|a| a.get(x)).flatten().copied(),
        east: m.get(y).map(|a| a.get(x + 1)).flatten().copied(),
        west: x
            .checked_sub(1)
            .map(|nn| m.get(y).map(|a| a.get(nn)))
            .flatten()
            .flatten()
            .copied(),
    }
}

fn next(m: &M, p: P) -> Option<(Heading, Option<Terrain>)> {
    let (h, po) = p;
    let s = surr(m, p);
    let next_location = match h {
        N => s.north,
        S => s.south,
        E => s.east,
        W => s.west,
    };
    next_location.map(|terr| match terr {
        Empty(_, _) => s.forward(h),
        Wall(_, _) => s.right(h),
    })
}
