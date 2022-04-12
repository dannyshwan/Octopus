/*
*	Student: Daniel Shwan
 */
package main

import (
	"bytes"
	"fmt"
	"strings"
	"sync"
	"unicode"
)

// This program encrypts an array of messages
func main() {
	// Create waitgroup
	var wg sync.WaitGroup

	// List of messages
	messages:= []string{"Csi2520", "Csi2120", "3 Paradigms", 
		"Go is 1st", "Prolog is 2nd", "Scheme is 3rd", 
		"uottawa.ca", "csi/elg/ceg/seg", "800 King Edward"}

	wg.Add(3)
	intervals := len(messages)/3
	secondInterval := intervals*2

	// call go function
	go CaesarCipherList(messages[:intervals],2,&wg) // process first 1/3 of messages
	go CaesarCipherList(messages[intervals:secondInterval],2,&wg) // process second 1/3 of messages
	go CaesarCipherList(messages[secondInterval:],2,&wg) // process last 1/3 of messages

	wg.Wait()

	// print results
	for _, m := range messages {
		fmt.Printf("%s\n", m)
	}
}

// CaesarCipherList() encrypts an array of messages and passes the 
// encrypted messages to the channel
func CaesarCipherList(msg []string, shift int, wg *sync.WaitGroup) {
	for i, m := range msg {
		msg[i] = CaesarCipher(m, shift)
	}
	wg.Done()
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