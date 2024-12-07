use itertools::Itertools;
use itertools::FoldWhile::{Continue, Done};
use std::collections::HashMap;
use std::collections::HashSet;
use std::fs;
use std::iter;

type T = (usize, usize);

fn main() {
    let file_in = fs::read_to_string("data2.txt").unwrap();
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

    let s = &make_map(&mut rules);

    dbg!(order.iter().filter(|o| check(&s, o)).map(middle).sum::<usize>());
    
}

fn make_map(r: &mut Vec<T>) -> HashMap<usize, HashSet<usize>> {
    r.sort();
    let mut grouped: HashMap<usize, HashSet<usize>> = HashMap::new();

    for (key, chunk) in &r.into_iter().chunk_by(|elt| elt.0) {
        grouped.insert(key, chunk.map(|x| x.1).collect());
    }
    grouped
}

fn a(b: HashSet<usize>, c: usize) -> HashSet<usize> {
    b.into_iter().chain(iter::once(c)).collect()
}

fn middle<T: Copy>(v: &Vec<T>) -> T {
   v[v.len()/2]
}

fn check(r: &HashMap<usize, HashSet<usize>>, o: &Vec<usize>) -> bool {
    let empty = HashSet::new();
    let res: (bool, HashSet<usize>) = o.into_iter().fold_while((true, HashSet::new()), |(inconsis, seen), x| {
        let intersect = seen.intersection(&r.get(x).unwrap_or(&empty));
        if intersect.count() == 0 {
           Continue((inconsis, a(seen, *x)))
        } else {
           Done((false, a(seen, *x)))
        }
    }).into_inner();
    res.0
}

