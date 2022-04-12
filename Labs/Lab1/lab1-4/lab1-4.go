/**
Student: Daniel Yuan Shwan
*/
package main

import "fmt"

// Define a suitable structure
type Class struct {
	NStudents int
	Professor string
	Avg float64
}

func main() {
	// Create a dynamic map and add the courses CSI2120 and CSI2110 to the map 
	var classes = map[string]Class{
		"CSI2120": {
			211, "Moura", 81,
		},
		"CSI2110": {
			186, "Lang", 79.5,
		},
	}
	
	for k, v := range classes {
		fmt.Printf("Course Code: %s\n", k)
		fmt.Printf("Number of students: %d\n", v.NStudents)
		fmt.Printf("Professor: %s\n", v.Professor)
		fmt.Printf("Average: %f\n\n", v.Avg)
	}
}