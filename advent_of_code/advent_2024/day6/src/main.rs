use crate::Heading::*;
use crate::Terrain::*;
use itertools::FoldWhile::{Continue, Done};
use itertools::Itertools;
use std::collections::HashSet;
use std::fs;
use std::iter;
use std::hash::Hash;
use std::cmp::Eq;

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
    fn forward(&self, h: Heading) -> (Heading, Option<Terrain>) {
        match h {
            N => (N, self.north),
            S => (S, self.south),
            E => (E, self.east),
            W => (W, self.west),
        }
    }
    fn right(&self, h: Heading) -> (Heading, Option<Terrain>) {
        match h {
            N => (E, self.east),
            S => (W, self.west),
            E => (S, self.south),
            W => (N, self.north),
        }
    }
}

fn main() {
    let file_in = fs::read_to_string("data2.txt").unwrap();
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
    let person = P { heading: N, coord: person };

    // dbg!(surr(&m, (N, (0, 0))));

    dbg!(full_path(person, &m).into_iter().map(|p| p.coord).collect::<HashSet<(usize, usize)>>().len());
}

fn a<T: Copy + Hash + Eq>(s: HashSet<T>, v: T) -> HashSet<T> {
    s.into_iter().chain(iter::once(v)).collect()
}

fn full_path(person: P, m: &M) -> HashSet<P> {
    (0..)
        .fold_while(
            (person, iter::once(person).collect()),
            |(acc, set), _| match next(&m, acc) {
                None => Done((acc, set)),
                Some((_, None)) => Done((acc, set)),
                Some((_, Some(Wall))) => panic!("Ran through wall"),
                Some((heading, Some(Empty(ny, nx)))) => {
                    let p = P{heading: heading, coord: (ny, nx)};
                    Continue((p, a(set, p)))
                }
            },
        )
        .into_inner()
        .1
}

fn is_loop(before: &HashSet<P>, now: &P) -> bool {
    before.contains(now)
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

fn next(m: &M, p: P) -> Option<(Heading, Option<Terrain>)> {
    let h = p.heading;
    let s = surr(m, p);
    let next_location = match h {
        N => s.north,
        S => s.south,
        E => s.east,
        W => s.west,
    };
    next_location.map(|terr| match terr {
        Empty(_, _) => s.forward(h),
        Wall => s.right(h),
    })
}
