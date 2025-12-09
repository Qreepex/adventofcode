package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func part2() {
	raw, err := os.ReadFile("./input")
	if err != nil {
		log.Fatal(err)
		return
	}

	data := string(raw)

	rawPoints := strings.Split(data, "\r\n")
	points := make([]Point, len(rawPoints))

	// alle punkte wo x oder y gleich sind, sind connected
	// wenn das ein loop ergibt, sind in dem loop alle auch grün

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

	// TODO
}
