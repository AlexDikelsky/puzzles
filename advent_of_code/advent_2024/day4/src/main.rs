use regex::Regex;
use std::cmp;
use std::fs;
use std::iter;

type M = Vec<Vec<char>>;

fn main() {
    let file_in = fs::read_to_string("data1.txt").unwrap();
    let m: M = file_in.lines().map(|x| x.chars().collect()).collect();
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

    dbg!(fwdi(&m[0]));
    dbg!(bwdi(&m[0]));
}

fn fwd(v: &Vec<char>, reg: &Regex) -> usize {
    reg.find_iter(&v.into_iter().collect::<String>()).count()
}

fn bwd(v: &Vec<char>, reg: &Regex) -> usize {
    fwd(&v.iter().copied().rev().collect(), reg)
}

fn fwdi(v: &Vec<char>) -> Vec<usize> {
    v.windows(3)
        .zip(0..)
        .filter_map(|(w, i)| {
            if w == ['M', 'A', 'S'] {
                Some(i + 1)
            } else {
                None
            }
        })
        .collect()
}

fn bwdi(v: &Vec<char>) -> Vec<usize> {
    fwdi(&v.clone().into_iter().rev().collect())
        .into_iter()
        .map(|x| v.len() - x - 1)
        .collect()
}

fn check_fwd_bwd(m: &M, reg: &Regex) -> usize {
    m.iter().map(|r| fwd(r, &reg)).sum::<usize>() + m.iter().map(|r| bwd(r, &reg)).sum::<usize>()
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

fn diag_main(m: &M) -> Vec<char> {
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
