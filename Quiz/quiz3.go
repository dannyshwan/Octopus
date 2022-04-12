/*
	Student: Daniel Yuan Shwan
	Number: 300013694
*/
package main

import (
	"fmt"
	"sync"
)

func main() {
	const size = 8 // if this size is changed, change the dimensions of x
  x := []int{3, 1, 4, 1, 5, 9, 2, 6}
  var y [size]int
	var wg sync.WaitGroup // create waitGroup for synchronization

	wg.Add(size)
  // parallel loop
  for i, v := range x {
    go func (i int, v int, wait *sync.WaitGroup) {
      y[i]= calcul(v)
			wait.Done() // signals that goroutine is over
    }(i,v, &wg) // call to goroutine
  }

  // add synchronization
	wg.Wait() // wait for goroutines to finish
  fmt.Println(y)
}

// you can add a channel to the list of parameters
func calcul(v int) (int) {
  return 2*v*v*v+v*v
}