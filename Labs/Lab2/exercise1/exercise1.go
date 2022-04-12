/*
  Name: Daniel Yuan Shwan
*/
package main

type dog struct {
  name string
  race string
  female bool
}

func (d *dog) Rename(name string) {
  d.name = name
}

func main() {
	fido := dog {"Fido", "Poodle", false }
	fido.Rename("Cocotte")
}