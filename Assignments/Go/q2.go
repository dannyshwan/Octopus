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

// This program encrypts an array of messages
func main() {
	// Create channels
	ch := make(chan string)

	// List of messages
	messages:= []string{"Csi2520", "Csi2120", "3 Paradigms", 
		"Go is 1st", "Prolog is 2nd", "Scheme is 3rd", 
		"uottawa.ca", "csi/elg/ceg/seg", "800 King Edward"}

	// call go function
	go CaesarCipherList(messages[:],2, ch)

	// print results
	for encryptedStr := range ch {
		fmt.Printf("%s\n", encryptedStr)
	}
}

// CaesarCipherList() encrypts an array of messages and passes the 
// encrypted messages to the channel
func CaesarCipherList(msg []string, shift int, ch chan string) {
	for _, m := range msg {
		ch <- CaesarCipher(m, shift)
	}
	close(ch) // Add synchronization
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