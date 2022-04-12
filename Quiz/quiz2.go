/*
	Student: Daniel Yuan Shwan
	Number: 300013694
*/
package main

import (
	"fmt"
)
func main() {
	x := []int{3, 1, 4, 1, 5, 9, 2, 6}
	var y [8]int
	done := make(chan bool, 2) // create boolean channel

	// parallel loop in 2 slices
	go calcul2(x[:4], y[:4], done, 1)
	go calcul2(x[4:], y[4:], done, 2)

	// Signal meet
	<- done
	<- done
	fmt.Println(y)
}
func calcul2(in []int, out []int, done chan bool, num int) {
	fmt.Println(num)
	for i, v := range in {
		out[i] = 2*v*v*v + v*v
	}
	done <- true // end signal
}