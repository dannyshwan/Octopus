/*
*	Student: Daniel Shwan
 */
package main

import (
	"bytes"
	"fmt"
	"strings"
	"unicode"
)

// This program encrypts a message with a given shift
func main() {
	fmt.Println(CaesarCipher("I love CS!", 5))
}

// CaesarCipher() encrypts a given string through the Caesar Cipher scheme
// The function will return the encrypted string
func CaesarCipher(m string, shift int) string {
	var r []rune // slice of unicode chars
	trimString := strings.ReplaceAll(m," ", "") // remove spaces
	trimString = strings.ToUpper(strings.TrimSpace(trimString)) // capitalize string and remove whitespaces

	for _,c := range trimString {
		if unicode.IsLetter(c){
			shiftedC := c+rune(shift) // Shift string
			// Checks if shifted char is still a letter. If not, shift back 26
			if !unicode.IsLetter(shiftedC) { 
				shiftedC = shiftedC-26
			}
			r= append(r,shiftedC) // add character to slice of unicode
		}
	}
	// from slice of unicode to string
	var buffer bytes.Buffer
	for _,c := range r {
		buffer.WriteRune(c)
	}
	encryptedString := buffer.String()
	return encryptedString
}