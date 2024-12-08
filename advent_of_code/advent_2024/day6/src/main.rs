use crate::Heading::*;
use crate::Terrain::*;
use itertools::FoldWhile::{Continue, Done};
use itertools::Itertools;
use std::cmp::Eq;
use std::collections::HashSet;
use std::fs;
use std::hash::Hash;
use std::iter;

#[derive(Debug, Copy, Clone, Eq, Hash, PartialEq)]
enum Heading {
    N,
    S,
    E,
    W,
}

#[derive(Debug, Copy, Clone)]
enum Terrain {
    Empty(usize, usize),
    Wall,
}

type M = Vec<Vec<Terrain>>;

#[derive(Debug, Copy, Clone)]
struct D {
    north: Option<Terrain>,
    south: Option<Terrain>,
    east: Option<Terrain>,
    west: Option<Terrain>,
}

#[derive(Debug, Copy, Clone, Eq, PartialEq, Hash)]
struct P {
    heading: Heading,
    coord: (usize, usize),
}

impl D {
    fn forward(&self, h: Heading) -> Option<(Heading, Terrain)> {
        match h {
            N => self.north.map(|x| (N, x)),
            S => self.south.map(|x| (S, x)),
            E => self.east.map(|x| (E, x)),
            W => self.west.map(|x| (W, x)),
        }
    }
    fn right(&self, h: Heading) -> Option<(Heading, Terrain)> {
        match h {
            N => self.east.map(|x| (E, x)),
            S => self.west.map(|x| (W, x)),
            E => self.south.map(|x| (S, x)),
            W => self.north.map(|x| (N, x)),
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
                    '#' => Wall,
                    '^' => {
                        person = (row, col);
                        Empty(row, col)
                    }
                    _ => panic!("parse error ☹️"),
                })
                .collect_vec()
        })
        .collect_vec();
    let person = P {
        heading: N,
        coord: person,
    };


    dbg!(full_path(person, &m, false).0
        .into_iter()
        .map(|p| p.coord)
        .collect::<HashSet<(usize, usize)>>()
        .len());
    dbg!(full_path(person, &m, false).1);
    // dbg!(replace(&m, P {heading: N, coord: (1, 0)}));
}

fn a<T: Copy + Hash + Eq>(s: HashSet<T>, v: T) -> HashSet<T> {
    s.into_iter().chain(iter::once(v)).collect()
}

fn full_path(person: P, m: &M, top_level: bool) -> (HashSet<P>, usize) {
    let z = (0..)
        .fold_while(
            (person, iter::once(person).collect::<HashSet<P>>(), 0),
            |(acc, set, so_far), _| match next(&m, acc) {
                None => Done((acc, set, so_far)),
                // Some((_, None)) => Done((acc, set, so_far)),
                Some((p, Wall)) => panic!("Ran through wall at {:?}", p),
                Some((heading, Empty(ny, nx))) => {
                    let p = P {
                        heading: heading,
                        coord: (ny, nx),
                    };
                    if set.contains(&p) {
                        Done((p, set, 1))
                    } else {
                        if top_level {
                            let new_grid = &replace(m, p);
                            let n = full_path(acc, new_grid, false);
                            Continue((p, a(set, p), so_far))
                        } else {
                            Continue((p, a(set, p), so_far))
                        }
                    }
                }
            },
        )
        .into_inner();
    (z.1, z.2)
}

fn replace(m: &M, p: P) -> M {
    (0..m.len())
        .map(|col| {
            (0..m[0].len())
                .map(|row| {
                    if p.coord == (col, row) {
                        Wall
                    } else {
                        m[col][row]
                    }
                })
                .collect_vec()
        })
        .collect_vec()
}

fn surr(m: &M, p: P) -> D {
    let (y, x) = p.coord;
    D {
        north: y
            .checked_sub(1)
            .and_then(|nn| m.get(nn).map(|a| a.get(x)))
            .flatten()
            .copied(),
        south: m.get(y + 1).and_then(|a| a.get(x)).copied(),
        east: m.get(y).and_then(|a| a.get(x + 1)).copied(),
        west: x
            .checked_sub(1)
            .and_then(|nn| m.get(y).map(|a| a.get(nn)))
            .flatten()
            .copied(),
    }
}

fn next(m: &M, p: P) -> Option<(Heading, Terrain)> {
    let h = p.heading;
    let s = surr(m, p);
    let next_location = match h {
        N => s.north,
        S => s.south,
        E => s.east,
        W => s.west,
    };
    next_location.map(|t| n(s, t, h))
}

fn n(s: D, terr: Terrain, h: Heading) -> (Heading, Terrain) {
    match terr {
        Empty(_, _) => s.forward(h).unwrap(),
        Wall => s.right(h).unwrap()
    }
}
