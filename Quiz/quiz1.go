/*
	Student: Daniel Yuan Shwan
	Number: 300013694
*/

package main

import (
	"fmt"
	"math"
)

func getMinMax(nums []int) (int, int) {
	min := math.MaxInt
	max := math.MinInt

	for i := range nums {
		if nums[i] > max {
			max = nums[i]
		}

		if nums[i] < min {
			min = nums[i]
		}
	}
	return min,max
}

func main() {

	a := [5]int{12, -6, 9, 87, -11}
	b := [7]int{1, 2, 3, -4, -5, -6, 9}

	min, max := getMinMax(a[:])
	fmt.Println("a:")
	fmt.Println("Min= ", min)
	fmt.Println("Max= ", max)

	min, max = getMinMax(b[:])
	fmt.Println("b:")
	fmt.Println("Min= ", min)
	fmt.Println("Max= ", max)
}