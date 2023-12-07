module main

import os

struct Race {
	dist i64
	time i64
}

fn main() {
	if os.args.len < 2 {
		panic("Invalid file name")
	}
	file_path := os.args[1]
	lines := os.read_lines(file_path)!
	dists := lines[1].split_any(' ').filter(!it.is_blank())[1..]
	times := lines[0].split(' ').filter(!it.is_blank())[1..]

	part1 := part1_races(times, dists)!
	part2 := part2_one_race(times, dists)!

	println("Part 1 -> ${part1}")
	println("Part 2 -> ${part2}")
}

fn part1_races(times []string, dists []string) !i64 {
	mut races := []Race{}
	for i, time in times {
		races << Race{
			time: time.parse_int(10, 32)!
			dist: dists[i].parse_int(10, 32)!
		}
	}
	mut result := 1
	for race in races {
		mut number_of_speed := 0
		for speed in 1..race.time{
			remaining_time := race.time - speed
			dist_in_remaining_time := remaining_time * speed
			if dist_in_remaining_time > race.dist {
				number_of_speed = number_of_speed + 1
			}
		}
		result = result * number_of_speed
	}	
	return result
}

fn part2_one_race(times []string, dists []string) !i64 {
	time_str := times.join("")
	dist_str := dists.join("")

	time := time_str.parse_int(10, 64)!
	dist := dist_str.parse_int(10, 64)!
	mut start := i64(0)
	mut end := i64(0)
	for speed in 1..time{
		remaining_time := time - speed
		dist_in_remaining_time := remaining_time * speed
		if dist_in_remaining_time > dist {
			start = speed
			break
		}
	}
	mut speed := time
	for speed > 0 {
		remaining_time := time - speed
		dist_in_remaining_time := remaining_time * speed
		if dist_in_remaining_time > dist {
			end = speed
			break
		}
		speed--
	}
	return end-start + 1
}