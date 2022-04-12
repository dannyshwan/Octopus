/**
Student: Daniel Yuan Shwan
*/
package main

import "fmt"

type Person struct {
	lastName  string
	firstName string
	iD        int
}

func inPerson(person *Person, id int) (int, error) {
	var (
		firstName string
		lastName string
	)
	nextId := id + 1 // Prepares id for next person

	// Gets the input for the name from the console
	fmt.Printf("\nPlease input a name: ")
	_, err := fmt.Scanf("%s %s", &firstName, &lastName)

	person.firstName = firstName
	person.lastName = lastName
	person.iD = id

	return nextId, err
}

func printPerson(person Person) {
	msg := fmt.Sprintf("Hello %s %s (#%d)", person.firstName, person.lastName, person.iD) 
	fmt.Println(msg)
}

func main() {

	nextId := 101
	for {
		var (
			p	Person
			err error
		)
		nextId, err = inPerson(&p, nextId)
		if err != nil {
			fmt.Println("Invalid entry ... exiting")
			break
		}
		printPerson(p)
	}
}