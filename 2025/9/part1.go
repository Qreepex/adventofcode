package main

import (
	"fmt"
	"strconv"
	"strings"
)

func part1() {
	rawPoints := strings.Split(data, "\r\n")
	points := make([]Point, len(rawPoints))

	for i, rawPoint := range rawPoints {
		coords := strings.Split(rawPoint, ",")

		x, err := strconv.Atoi(coords[0])
		y, err := strconv.Atoi(coords[1])
		if err != nil {
			fmt.Print(err)
			return
		}

		point := Point{
			X: x,
			Y: y,
		}

		points[i] = point
	}

	p1 := points[0]
	p2 := points[1]
	area := calcArea(p1, p2)
	for i := range len(points) {
		for j := i + 1; j < len(points); j++ {
			pi := points[i]
			pj := points[j]

			localArea := calcArea(pi, pj)
			if localArea > area {
				area = localArea
				p1 = pi
				p2 = pj
			}
		}
	}

	fmt.Printf("Part 1\n")
	fmt.Printf("%v %v\n", p1, p2)
	fmt.Printf("%d\n", area)
}
