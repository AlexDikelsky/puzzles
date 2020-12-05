use md5;

fn main() {
    let input_string = "ckczppom";

    let mut part1_found = false;
    let mut part2_found = false;

    (0..).find(|n| {
        let in_bytes: Vec<u8> = input_string.bytes().chain(n.to_string().bytes()).collect();
        let hash = format!("{:x}", md5::compute(in_bytes)); 
        if !part1_found && hash.starts_with("00000") {
            println!("Part 1: {}", n);
            part1_found = true;
        };
        if hash.starts_with("000000") {
            println!("Part 2: {}", n);
            part2_found = true;
        };
        part1_found && part2_found
    });
}
