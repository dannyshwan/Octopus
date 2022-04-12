/**
Student: Daniel Yuan Shwan
*/
package main

import (
	"fmt"
	"math"
)

func round(num float64) (int, int) {
	return int(math.Ceil(num)), int(math.Floor(num))
}

func main() {
	originalNum := 1.454
	ceiling, floor := round(originalNum)
	fmt.Println("Original number: ", originalNum)
	fmt.Println("Ceiling of the number: ", ceiling)
	fmt.Println("Floor of the number: ", floor)
}