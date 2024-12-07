use itertools::Itertools;
use std::collections::HashMap;
use std::fs;

type T = (usize, usize);

fn main() {
    let file_in = fs::read_to_string("data.txt").unwrap();
    let m = file_in.split("\n\n").collect::<Vec<&str>>();
    let mut rules: Vec<(usize, usize)> = m[0]
        .lines()
        .map(|l| {
            let z = l
                .split("|")
                .map(|x| x.parse::<usize>().unwrap())
                .collect::<Vec<_>>();
            (z[0], z[1])
        })
        .collect();

    let order: Vec<Vec<usize>> = m[1]
        .lines()
        .map(|l| l.split(",").map(|x| x.parse::<usize>().unwrap()).collect())
        .collect();

    dbg!(&m);
    dbg!(&rules);
    dbg!(&make_map(&mut rules));
}

fn make_map(r: &mut Vec<T>) -> HashMap<usize, Vec<usize>> {
    r.sort();
    let mut grouped: HashMap<usize, Vec<usize>> = HashMap::new();

    for (key, chunk) in &r.into_iter().chunk_by(|elt| elt.0) {
        grouped.insert(key, chunk.map(|x| x.1).collect());
    }
    grouped
}
