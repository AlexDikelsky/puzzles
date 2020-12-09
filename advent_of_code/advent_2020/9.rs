use std::fs;

fn main() {

    let file_in = fs::read_to_string("day9_in.txt").unwrap();

    let input: Vec<usize> = file_in.lines().map(|x| x.parse().unwrap()).collect();

    // Part 1
    // input.windows(26).find(|window| {
    //     let contains_25 = window[0..25].iter().zip(0..).any(|(x, x_i)| {
    //         window[0..25].iter().zip(0..).any(|(y, y_i)| {
    //             x + y == window[25] && x_i != y_i
    //         })
    //     });
    //     if contains_25 {
    //         false
    //     } else {
    //         dbg!(window[25]);
    //         true
    //     }
    // });

    let part1: usize = 41682220;
    let part2 = (2..(input.len())).find(|size| {
        let contains_sum_to_n = input.windows(*size).any(|window| {
            let sum = window.iter().sum::<usize>();
            if sum == part1 {
                dbg!(window);
                dbg!(window.iter().min().unwrap() + window.iter().max().unwrap());
                assert!(false);
            }
            false
        });
        false
        // if contains_sum_to_n {
        //     dbg!(size);
        //     false
        // } else {
        //     true
        // }
    });

    dbg!(part2);


}
