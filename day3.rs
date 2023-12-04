use std::fs;
#[derive(Debug)]
struct Gears {
    numbers: Vec<String>,
    id: String,
}

const GEAR_CALC: bool = true; // Part 1 false; Part 2 true

fn main() {
    std::env::set_var("RUST_BACKTRACE", "1");
    let argv: Vec<String> = std::env::args().collect();
    if argv.len() < 2 {
        eprintln!("Invalid file path");
        std::process::exit(1);
    }
    let file_path = &argv[1];
    let content = fs::read_to_string(file_path).unwrap();

    let lines: Vec<&str> = content.split("\n").collect();
    let mut gears: Vec<Gears> = vec![];
    let mut result: u64 = 0;
    let mut line_index = 0;
    while line_index < lines.len() {
        let line = lines[line_index];
        let chars_in_line: Vec<char> = line.chars().collect();
        let mut char_index = 0;
        while char_index < chars_in_line.len() {
            let char = chars_in_line[char_index];
            if char == '.' {
                char_index += 1;
                continue;
            } else if char.is_digit(10) {
                let number = get_number_from_line(char_index, &chars_in_line);
                // println!("{}", number);
                let end_index = char_index + number.len() - 1;

                if char_index != 0 && chars_in_line[char_index - 1] != '.' {
                    if chars_in_line[char_index - 1] == '*' {
                        add_to_gears(
                            &mut gears,
                            format!("{}-{}", char_index - 1, line_index),
                            &number,
                        )
                    }
                    result += number.parse::<u64>().unwrap();
                    char_index = end_index + 1;
                    continue;
                }
                if end_index != chars_in_line.len() - 1 && chars_in_line[end_index + 1] != '.' {
                    if chars_in_line[end_index + 1] == '*' {
                        add_to_gears(
                            &mut gears,
                            format!("{}-{}", end_index + 1, line_index),
                            &number,
                        )
                    }
                    result += number.parse::<u64>().unwrap();
                    char_index = end_index + 1;
                    continue;
                }
                if line_index != 0 {
                    let b_line: Vec<char> = lines[line_index - 1].chars().collect();
                    let s = if char_index == 0 { 0 } else { char_index - 1 };
                    let e = if end_index + 2 > b_line.len() {
                        b_line.len()
                    } else {
                        end_index + 2
                    };
                    if check_edges(b_line[s..e].to_vec()) {
                        result += number.parse::<u64>().unwrap();
                        char_index = end_index + 1;
                        continue;
                    }
                    let gear_index = find_gear_index(&b_line, s, e);
                    if gear_index != -1 {
                        add_to_gears(
                            &mut gears,
                            format!("{}-{}", gear_index, line_index - 1),
                            &number,
                        )
                    }
                }
                if line_index != lines.len() - 1 {
                    let b_line: Vec<char> = lines[line_index + 1].chars().collect();
                    let s = if char_index == 0 { 0 } else { char_index - 1 };
                    let e = if end_index + 2 > b_line.len() {
                        b_line.len()
                    } else {
                        end_index + 2
                    };
                    if check_edges(b_line[s..e].to_vec()) {
                        result += number.parse::<u64>().unwrap();
                        char_index = end_index + 1;
                        continue;
                    }
                    let gear_index = find_gear_index(&b_line, s, e);
                    if gear_index != -1 {
                        add_to_gears(
                            &mut gears,
                            format!("{}-{}", gear_index, line_index + 1),
                            &number,
                        )
                    }
                }
                char_index = end_index;
            }
            char_index += 1;
        }
        line_index += 1;
    }
    if GEAR_CALC {
        result = calc_gears(gears);
    }
    println!("Total numbers = {result}");
}

fn get_number_from_line(start_index: usize, chars: &Vec<char>) -> String {
    let mut result = String::from("");
    let mut index = start_index;
    while index < chars.len() {
        if chars[index].is_digit(10) {
            result.push(chars[index]);
            index += 1
        } else {
            break;
        }
    }
    return result;
}

fn check_edges(edges: Vec<char>) -> bool {
    for char in edges {
        if !GEAR_CALC {
            if char != '.' {
                return true;
            }
        } else {
            if char != '.' && char != '*' {
                return true;
            }
        }
    }
    return false;
}
fn find_gear_index(edges: &Vec<char>, start: usize, end: usize) -> i32 {
    let index: i32 = -1;

    for i in start..end {
        if edges[i] == '*' {
            return i as i32;
        }
    }
    return index;
}

fn add_to_gears(gears: &mut Vec<Gears>, id: String, number: &str) {
    if gears.len() != 0 {
        let mut i = 0;
        while i < gears.len() {
            if gears[i].id == id {
                gears[i].numbers.push(String::from(number));
                return;
            }
            i += 1;
        }
    }
    gears.push(Gears {
        numbers: vec![String::from(number)],
        id: String::from(id),
    })
}

fn calc_gears(gears: Vec<Gears>) -> u64 {
    let mut result: u64 = 0;
    for gear in gears {
        // println!("{:?}", gear);
        let mut gear_result = 1;
        if gear.numbers.len() <= 1 {
            continue;
        }
        for number in gear.numbers {
            let num = number.parse::<u64>().unwrap();
            gear_result *= num;
        }
        result += gear_result
    }
    return result;
}
