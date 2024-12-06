use std::fs;

fn main() {
    let file_in = fs::read_to_string("data.txt").unwrap();
    let parsed: Vec<Vec<isize>> = file_in.lines().map(|line| line.split(' ').map(|x| x.parse::<isize>().unwrap()).collect()).collect();

    // dbg!(&schedule);
    // dbg!(parsed.iter().map(m).collect::<Vec<Vec<isize>>>());
    let k = parsed.iter().map(m).map(check).collect::<Vec<bool>>();
    let l = parsed.iter().map(m).map(check2).collect::<Vec<bool>>();
    dbg!(k.into_iter().map(|x| if x {1} else {0}).sum::<isize>());
    dbg!(l.into_iter().map(|x| if x {1} else {0}).sum::<isize>());
}

fn m(v: &Vec<isize>) -> Vec<isize> {
  v.iter().zip(v.iter().skip(1)).map(|(a, b)| a - b).collect()
}

fn check(v: Vec<isize>) -> bool {
  v.iter().all(|x| (*x <= 3) && (*x > 0)) ||
  v.iter().all(|x| (*x >= -3) && (*x < 0))
}

fn check2(v: Vec<isize>) -> bool {
  let g = v.iter().filter(|x| (**x <= 3) && (**x > 0)).collect::<Vec<&isize>>().len() <= 1;
  let h = v.iter().filter(|x| (**x >= -3) && (**x < 0)).collect::<Vec<&isize>>().len() <= 1;
  println!("{}, {}, {:?}", g, h, &v);
  g || h
}
