package main

import (
	"log"
	"math"
	"os"
	"strconv"
	"strings"
)

type Point struct {
	ID          int
	X           int
	Y           int
	Z           int
	ConnectedTo map[int]interface{}
	Circuit     int
}

var circuits = [][]Point{}
var points = make([]Point, 1000)

func main() {
	raw, err := os.ReadFile("./input")
	if err != nil {
		log.Fatal(err)
		return
	}

	data := string(raw)

	rawPoints := strings.Split(data, "\n")
	for i, rawPoint := range rawPoints {
		coords := strings.Split(rawPoint, "")

		x, err := strconv.Atoi(coords[0])
		y, err := strconv.Atoi(coords[1])
		z, err := strconv.Atoi(coords[2])
		if err != nil {
			return
		}

		point := Point{
			ID:      i,
			X:       x,
			Y:       y,
			Z:       z,
			Circuit: -1,
		}

		points = append(points, point)
	}

	for range 1000 {
		a, b, _ := getClosestPair()

		a.ConnectedTo[b.ID] = true
		b.ConnectedTo[a.ID] = true

		if a.Circuit != -1 {
			bCircuit := circuits[b.Circuit]
			aCircuit := circuits[b.Circuit]
			for _, point := range bCircuit {
				point.Circuit = a.Circuit

			}

		}
	}
}

func getClosestPair() (Point, Point, float64) {
	pair := []int{0, 1}
	distance := calculateDistance(points[0], points[1])

	totalPoints := len(points)
	for i := range totalPoints {
		for j := i + 1; i < totalPoints; j++ {
			pointI := points[i]
			pointJ := points[j]

			if pointI.ConnectedTo[j] == true || pointJ.ConnectedTo[i] == true {
				continue
			}

			if pair[0] != pointI.ID && pair[1] != pointJ.ID {
				dis := calculateDistance(pointI, pointJ)
				if dis < distance {
					distance = dis
					pair = []int{pointI.ID, pointJ.ID}
				}
			}
		}
	}

	return points[pair[0]], points[pair[1]], distance
}

func calculateDistance(point1, point2 Point) float64 {
	diff1 := point1.X - point2.X
	diff2 := point1.Y - point2.Y
	diff3 := point1.Z - point2.Z

	sum := diff1*diff1 + diff2*diff2 + diff3*diff3

	return math.Sqrt(float64(sum))
}
