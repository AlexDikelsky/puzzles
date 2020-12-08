use std::fs;
use regex::Regex;
use std::collections::HashSet;
use std::collections::HashMap;
use std::iter;

use Instruction::*;

const INITAL_STATE: State = State { line: 0, accum: 0 };

#[derive(Debug, Copy, Clone)]
enum Instruction {
    Acc,
    Jmp,
    Nop,
}

#[derive(Debug, Copy, Clone)]
struct State {
    line: isize,
    accum: isize,
}

fn main() {
    let file_in = fs::read_to_string("day8_in.txt").unwrap();

    let valid = Regex::new(r"^(jmp|acc|nop) ((?:\+|-)(?:\d+))$").unwrap();

    let program: Vec<(Instruction, isize)> = file_in
        .lines()
        .map(|line| {
            let captures = valid.captures(line).unwrap();
            let instruct = match &captures[1] {
                "jmp" => Jmp,
                "acc" => Acc,
                "nop" => Nop,
                a => panic!("Invalid instruction {}", a),
            };
            (instruct, captures[2].parse().unwrap())
        })
        .collect();

    let visited = HashSet::new();
    println!("Part 1: {}", run(&program, INITAL_STATE, &visited).err().unwrap());
    try_all(program);
    // dbg!(match run(&program, INITAL_STATE, &visited) {
    //     Ok(_) => false,
    //     Err(a) => a.starts_with("Terminated successfully"),
    // });
}

fn try_all(program: Vec<(Instruction, isize)>) {
    program.iter().zip(0..).find(|(_, line_num)| {
        let new_program: Vec<(Instruction, isize)> = program.iter().zip(0..).map(|(x, y)| {
            if &y == line_num {
                (match x.0 {
                    Acc => Acc,
                    Jmp => Nop,
                    Nop => Jmp,
                }, x.1)
            } else {
                *x
            }
        }).collect();
        // dbg!(&new_program);
        let visited = HashSet::new();
        match run(&new_program, INITAL_STATE, &visited) {
            Ok(_) => false,
            Err(a) => { 
                if a.starts_with("Terminated successfully") {
                    println!("Part 2: {}", &a); true
                } else {
                    false
                }
            }
        }
    });
}

fn run(
    program: &[(Instruction, isize)],
    state: State,
    visited: &HashSet<isize>,
) -> Result<State, String> {
    if visited.contains(&state.line) {
        Err(format!(
            "Repeated line {} with accum {}",
            state.line,
            state.accum
        ))
    } else if (state.line as usize) == program.len() {
        Err(format!(
            "Terminated successfully, acc = {}, line = {}",
            state.accum,
            state.line
        ))
    } else if (state.line as usize) > program.len() {
        Err(format!("Line is {}, which is out of range", state.line))
    } else {
        let here: (Instruction, isize) = program[state.line as usize];
        let as_set = iter::once(state.line).collect();
        run(
            program,
            State {
                line: {
                    match here.0 {
                        Jmp => state.line + here.1,
                        _ => state.line + 1,
                    }
                },
                accum: {
                    match here.0 {
                        Acc => state.accum + here.1,
                        _ => state.accum,
                    }
                },
            },
            &visited.union(&as_set).copied().collect(),
        )
    }
}
