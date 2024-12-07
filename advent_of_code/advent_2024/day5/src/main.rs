use std::collections::HashMap;
use std::fs;
use std::iter;

type T = (usize, usize);

fn main() {
    let file_in = fs::read_to_string("data.txt").unwrap();
    let m = file_in.split("\n\n").collect::<Vec<&str>>();
    let rules: Vec<(usize, usize)> = m[0]
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
    dbg!(&order);
}

fn make_map(r: Vec<T>) -> HashMap<usize, Vec<usize>> {
    let mut m: HashMap<usize, Box<dyn Iterator<Item = usize>>> = HashMap::new();

    r.into_iter().for_each(|(k, v)| {
        match m.get(&k) {
             Some(val) => { m[&k].chain(iter::once(v)); },
             None => {m.insert(k, Box::new(iter::once(v)));}
        }
    });
    m.into_iter().map(|(k,v)| (k, v.collect::<Vec<usize>>())).collect()
}
