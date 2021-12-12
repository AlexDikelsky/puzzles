use itertools::Itertools;
use std::collections::BTreeMap;
use std::collections::BTreeSet;
use std::fs;
use std::iter;
use crate::VisitsLeft::{Zero, One, Two};

type Graph<'a> = BTreeMap<&'a str, BTreeSet<&'a str>>;

#[derive(Debug,Copy,Clone,Eq,PartialEq)]
enum VisitsLeft {
    Zero,
    One,
    Two,
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

    // dbg!(&graph);
    // dbg!(follow(&graph, "start", "end", BTreeSet::from_iter(iter::once("start"))));
    dbg!(follow(&graph, "start", "end", BTreeSet::from_iter(iter::once("start"))).len());
}

fn is_small(v: &str) -> bool {
    v.to_lowercase() == v
}

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
    visited: BTreeSet<&'a str>,
) -> BTreeSet<Vec<&'a str>> {
    if start == end {
        BTreeSet::from_iter(iter::once(vec![end]))
    } else {
        g[start]
            .iter()
            .filter(|n| !visited.contains(*n))
            .map(|n| {
                follow(
                    g,
                    n,
                    end,
                    if is_small(n) {
                        visited.clone().into_iter().chain(iter::once(*n)).collect()
                    } else {
                        visited.clone()
                    },
                )
                .into_iter()
                .map(|path| iter::once(start).chain(path.into_iter()).collect())
            })
            .flatten()
            .collect()
    }
}
