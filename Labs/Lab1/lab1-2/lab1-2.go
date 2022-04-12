/**
Student: Daniel Yuan Shwan
*/
package main

import "fmt"

func main() {
	lineWidth := 5
	symb := "x"
	lineSymb := symb
	formatStr := fmt.Sprintf("%%%ds\n", lineWidth)

	for i := 0; i < lineWidth-1; i++ {
    fmt.Printf(formatStr, lineSymb)
		lineSymb += "x"
	}
	fmt.Printf(formatStr, lineSymb)

	for i := 0; i < lineWidth-1; i++ {
		lineSymb = lineSymb[:len(lineSymb)-1]
		fmt.Printf(formatStr, lineSymb)
	}
}