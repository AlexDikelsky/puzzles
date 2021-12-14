use crate::VisitsLeft::{One, Zero};
use itertools::Itertools;
use std::collections::BTreeMap;
use std::collections::BTreeSet;
use std::fs;
use std::iter;

type Graph<'a> = BTreeMap<&'a str, BTreeSet<&'a str>>;

#[derive(Debug, Copy, Clone, Eq, PartialEq, PartialOrd, Ord)]
enum VisitsLeft {
    Zero,
    One,
}

impl VisitsLeft {
    pub fn dec(&self) -> Self {
        match self {
            Zero => panic!("Dec of zero"),
            One => Zero,
            Two => One,
        }
    }
}

fn main() {
    let v = fs::read_to_string("data.txt").unwrap();
    let v = v
        .lines()
        .map(|line| {
            let z = line.split("-").collect_vec();
            (z[0], z[1])
        })
        .collect_vec();

    let graph: Graph = v
        .iter()
        .map(move |(a, b)| vec![*a, *b].into_iter())
        .flatten()
        .map(|x| (x, BTreeSet::new()))
        .collect();

    let graph: Graph = v.iter().fold(graph, |g, (a, b)| connect(a, b, g));

    let init = vec![("start", Zero), ("end", One)];

    // dbg!(&graph);
    // dbg!(follow(&graph, "start", "end", BTreeSet::from_iter(iter::once("start"))));
    dbg!(yikes(follow(
        &graph,
        "start",
        "end",
        BTreeMap::from_iter(init.clone().into_iter())
    )));

    dbg!(yikes(follow(
        &graph,
        "start",
        "end",
        BTreeMap::from_iter(init.into_iter())
    )).len());
}

fn is_small(v: &str) -> bool {
    v.to_lowercase() == v
}

// fn yikes(v: BTreeSet<Vec<&str>>) -> BTreeSet<Vec<&str>> {
//     v.into_iter().filter(|path| {
//         let mut path = path.into_iter().filter(|name| is_small(name)).collect_vec();
//         path.sort_unstable();
//         let v = path.len();
//         path.dedup();
//         (v == path.len()) || (path.len() + 1 == v)
//     }).collect()
// }

fn connect<'a>(a: &'a str, b: &'a str, g: Graph<'a>) -> Graph<'a> {
    g.into_iter()
        .map(|(name, edges)| match (name == a, name == b) {
            (true, _) => (a, edges.into_iter().chain(iter::once(b)).collect()),
            (_, true) => (b, edges.into_iter().chain(iter::once(a)).collect()),
            _ => (name, edges),
        })
        .collect()
}

fn follow<'a>(
    g: &'a Graph,
    start: &'a str,
    end: &'a str,
    visited: BTreeMap<&'a str, VisitsLeft>,
) -> BTreeSet<Vec<&'a str>> {
    if start == end {
        BTreeSet::from_iter(iter::once(vec![end]))
    } else {
        g[start]
            .iter()
            .filter_map(|n| {
                let visited = if is_small(n) {
                    match visited.get(*n) {
                        Some(Zero) => None,
                        Some(One) => Some(
                            visited
                                .clone()
                                .into_iter()
                                .chain(iter::once((*n, Zero)))
                                .collect(),
                        ),
                        None => Some(
                            visited
                                .clone()
                                .into_iter()
                                .chain(iter::once((*n, One)))
                                .collect(),
                        ),
                    }
                } else {
                    Some(visited.clone())
                };
                visited.map(|vis| {
                    follow(g, n, end, vis).into_iter().map(|path: Vec<&str>| {
                        iter::once(start)
                            .chain(path.into_iter())
                            .collect::<Vec<&str>>()
                    })
                })
            }).flatten()
            .collect()
    }
}
