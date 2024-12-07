use regex::Regex;
use std::cmp;
use std::fs;
use std::iter;
use std::collections::HashSet;

type T = (usize, usize);
type P = (char, (usize, usize));
type M = Vec<Vec<P>>;
type M2 = Vec<P>;

fn main() {
    let file_in = fs::read_to_string("data2.txt").unwrap();
    let m: M = file_in.lines().zip(0..).map(|(x, row)| x.chars().zip(0..).map(|(c, col)| (c, (row, col))).collect()).collect();
    let t: M = tps(&m);
    let se_diag: M = diags_se(&m);
    let ne_diag: M = diags_se(&m.clone().into_iter().rev().collect());

    let reg = Regex::new(r"XMAS").unwrap();
    let reg2 = Regex::new(r"MAS").unwrap();

    let ew = check_fwd_bwd(&m, &reg);
    let ns = check_fwd_bwd(&t, &reg);
    let sesw = check_fwd_bwd(&se_diag, &reg);
    let nenw = check_fwd_bwd(&ne_diag, &reg);
    dbg!(ew + ns + sesw + nenw);

    let sesw2: HashSet<T> = c2_fwd_bwd(&se_diag).into_iter().collect();
    let nenw2: HashSet<T> = c2_fwd_bwd(&ne_diag).into_iter().collect();
    let inter: HashSet<&T> = sesw2.intersection(&nenw2).collect();
    dbg!(&sesw2, &nenw2, &inter, inter.len());
}

fn fwd(v: &M2, reg: &Regex) -> usize {
    reg.find_iter(&v.into_iter().map(|x|x.0).collect::<String>()).count()
}

fn bwd(v: &M2, reg: &Regex) -> usize {
    fwd(&v.iter().copied().rev().collect(), reg)
}

fn fwdi(v: &M2) -> Vec<(usize, usize)> {
    v.windows(3)
        .zip(0..)
        .filter_map(|(w, i)| {
            if w.iter().map(|x| x.0).collect::<Vec<char>>() == vec!['M', 'A', 'S'] {
                Some(w[1].1)
            } else {
                None
            }
        })
        .collect()
}

fn bwdi(v: &M2) -> Vec<T> {
    fwdi(&v.clone().into_iter().rev().collect())
}

fn check_fwd_bwd(m: &M, reg: &Regex) -> usize {
    m.iter().map(|r| fwd(r, &reg)).sum::<usize>() + m.iter().map(|r| bwd(r, &reg)).sum::<usize>()
}

fn c2_fwd_bwd(m: &M) -> Vec<T> {
    m.iter().map(|r| fwdi(r).into_iter().chain(bwdi(r).into_iter())).flatten().collect()
}

fn tps(m: &M) -> M {
    (0..(m.len()))
        .map(|col| (0..(m[0].len())).map(|row| m[row][col]).collect())
        .collect()
}

fn diag_upper(m: &M) -> M {
    let (cols, rows) = (m[0].len(), m.len());
    (1..cols)
        .map(|col| (0..(rows - col)).map(|row| m[row][col + row]).collect())
        .collect()
}

fn diag_lower(m: &M) -> M {
    diag_upper(&tps(m))
}

fn diag_main(m: &M) -> M2 {
    (0..(cmp::min(m.len(), m[0].len())))
        .map(|rc| m[rc][rc])
        .collect()
}

fn diags_se(m: &M) -> M {
    diag_lower(m)
        .into_iter()
        .rev()
        .chain(iter::once(diag_main(m)))
        .chain(diag_upper(m))
        .collect()
}
