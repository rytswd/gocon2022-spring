package main

import (
	"fmt"
	"time"

	"go.rytswd/gocon-main-demo/demos/3-all-in-one/src/uk-farm/beef"
)

func main() {
	fmt.Printf("Cooking")
	time.Sleep(time.Second)
	fmt.Printf(".")
	time.Sleep(time.Second)
	fmt.Printf(".")
	time.Sleep(time.Second)
	fmt.Printf(".\n")

	m := beef.BeefForSteak()

	fmt.Printf("Here goes your Steak!\n\n-- Ingredients were:\n\t%s", m)
}
