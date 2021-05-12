use std::fs;

use num_bigint::BigInt;
use num_bigint::ToBigInt;
use num_integer::Integer;

fn main() {
    let file_in = fs::read_to_string("data.txt").unwrap();
    let schedule: Vec<Option<usize>>  = file_in.lines().nth(1).unwrap().split(',').map(|x| x.parse::<usize>().ok()).collect();
    let start_time = file_in.lines().nth(0).unwrap().parse::<usize>().unwrap();
    dbg!(part2big(&schedule));
}

fn part1(schedule: &Vec<Option<usize>>, start_time: usize) -> usize {
    let bus_numbers: Vec<usize> = schedule.iter().filter(|x| x.is_some()).map(|x| x.unwrap()).collect();
    let times: Vec<usize> = bus_numbers.iter().map(|x| (x * ((start_time+x) / x))).collect();
    let (min_time, min_bus) = times.iter().zip(bus_numbers.iter()).min_by_key(|(time, _)| *time).unwrap();
    (min_time - start_time) * min_bus
}

fn big_crt(eq1: (&BigInt, &BigInt), eq2: (&BigInt, &BigInt)) -> BigInt {
    let (a1, n1) = eq1;
    let (a2, n2) = eq2;
    let gcd_calc = BigInt::extended_gcd(n1, n2);
    let (m1, m2) = (gcd_calc.x, gcd_calc.y);
    let x1 = (a1 * m2 * n2) + (a2 * m1 * n1);
    let x2 = n1 * n2;
    let sol = if x1 < 0.to_bigint().unwrap() {
        (x1 % &x2) + x2
    } else {
        x1 % x2
    };
    sol.clone()
}

fn part2big(schedule: &Vec<Option<usize>>) -> BigInt {
    let answer_and_bus: Vec<(BigInt, BigInt)> =
        schedule.iter().zip(0..)
        .filter(|(bus, index)| bus.is_some())
        .map(|(bus, index)| (index.to_bigint().unwrap(), 
                             bus.unwrap().to_bigint().unwrap())).collect();

    let (a1, n1) = &answer_and_bus[0];
    let (a2, n2) = &answer_and_bus[1];
    let start = (big_crt((&a1, &n1), (&-a2, &n2)), n1 * n2);

    let sol: (BigInt, BigInt) = answer_and_bus[2..].iter().fold(start, |(a1, n1), (a2, n2)| {
        (big_crt((&a1, &n1), (&-a2, &n2)), n1 * n2)
    });
    sol.0
}
