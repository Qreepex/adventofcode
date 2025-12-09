package main

import (
	"log"
	"os"
)

type Point struct {
	X int
	Y int
}

var data string

func main() {
	raw, err := os.ReadFile("./input")
	if err != nil {
		log.Fatal(err)
		return
	}

	data = string(raw)

	part1()
	part2()
}

func calcArea(p1, p2 Point) int {
	x := p1.X - p2.X
	y := p1.Y - p2.Y

	if x < 0 {
		x = x * -1
	}

	if y < 0 {
		y = y * -1
	}

	x++
	y++

	return x * y
}
