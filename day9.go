package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal("ERROR: Invalid file path")
	}
	filePath := os.Args[1]
	fmt.Println(filePath)
	bytes, err := os.ReadFile(filePath)
	if err != nil { panic(err) }
	content := string(bytes)

	lines := strings.Split(content, "\n")

	resultPart1 := 0
	resultPart2 := 0
	for _, line := range lines {
		part1, part2 := handleLine(line)
		resultPart1 += part1
		resultPart2 += part2
	}
	fmt.Printf("Part 1 -> %d\n", resultPart1)
	fmt.Printf("Part 2 -> %d\n", resultPart2)
}

func handleLine(line string) (int, int) {
	numbersString := strings.Split(line, " ")
	numbers := []int{}
	for _, num := range numbersString {
		numbers = append(numbers, parseInt(num))
	}
	return getPrediction(numbers) + numbers[len(numbers) - 1],
	 numbers[0] - getLastHistory(numbers)
}

func parseInt(number string) int {
	num, err := strconv.Atoi(number)
	if err != nil {
		panic(err)
	}
	return num
}

func getPrediction(numbers []int) int {
	newNumbers := []int{}
	for i := 0; i < len(numbers) - 1; i++ {
		newNumbers = append(newNumbers, numbers[i + 1] - numbers[i])
	}
	for _, num := range newNumbers {
		if(num != 0) {
			return newNumbers[len(newNumbers) - 1] + getPrediction(newNumbers)
		}
	}
	return newNumbers[len(newNumbers) - 1]
}

func getLastHistory(numbers []int) int {
	newNumbers := []int{}
	for i := 0; i < len(numbers) - 1; i++ {
		newNumbers = append(newNumbers, numbers[i + 1] - numbers[i])
	}
	for _, num := range newNumbers {
		if(num != 0) {
			return newNumbers[0] - getLastHistory(newNumbers)
		}
	}
	return newNumbers[0]
}