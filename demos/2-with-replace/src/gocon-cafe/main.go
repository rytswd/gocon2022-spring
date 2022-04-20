package main

import (
	"fmt"
	"time"

	brazil_coffee "brazil.farm/coffee"
	colombia_coffee "colombia.farm/coffee"
	"uk.farm/milk"
)

func main() {
	MakeLatte()

	time.Sleep(time.Second)

	MakeFlatWhite()
}

func MakeLatte() {
	fmt.Printf("Brewing")
	time.Sleep(time.Second)
	fmt.Printf(".")
	time.Sleep(time.Second)
	fmt.Printf(".")
	time.Sleep(time.Second)
	fmt.Printf(".\n")

	c := brazil_coffee.FruityCoffee()
	m := milk.WarmMilk()

	fmt.Printf("Here goes your Latte!\n\n-- Ingredients:\n\t%s\n\t%s\n\n", c, m)
}

func MakeFlatWhite() {
	fmt.Printf("Brewing")
	time.Sleep(time.Second)
	fmt.Printf(".")
	time.Sleep(time.Second)
	fmt.Printf(".")
	time.Sleep(time.Second)
	fmt.Printf(".\n")

	c := colombia_coffee.DarkRoastedCoffee()
	m := milk.WarmMilk()

	fmt.Printf("Here goes your Flat White!\n\n-- Ingredients:\n\t%s\n\t%s\n", c, m)
}
