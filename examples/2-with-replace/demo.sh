#!/usr/bin/env bash

demo_helper_type_speed=5000

# shellcheck source=../../tools/demo-helper.sh
source "$(dirname "$0")/../../tools/demo-helper.sh"

comment "(1/9). Go into demo-src directory"
execute "mkdir demo-src; cd demo-src"

comment "(2/9). Let's make 3 directories, each as a module"
comment_r "NOTE: This is not quite microservice architecture, as this is more of a demo of monorepo"
demo_helper_type_speed=9000
execute 'mkdir brazil-farm; \
    pushd brazil-farm > /dev/null; \
    go mod init brazil.farm; \
    popd > /dev/null'
execute 'mkdir colombia-farm; \
    pushd colombia-farm > /dev/null; \
    go mod init colombia.farm; \
    popd > /dev/null'
execute 'mkdir uk-farm; \
    pushd uk-farm > /dev/null; \
    go mod init uk.farm; \
    popd > /dev/null'

demo_helper_type_speed=5000
comment "(3/9). Let's check how the files are structured right now"
execute "tree ."

comment "(4/9). Let's add some implementation code for each module"
comment_g "-- Copying code from examples/2-with-replace/src, which has each module defined the same way."
cp -r ../src/brazil-farm/coffee brazil-farm/
cp -r ../src/colombia-farm/coffee colombia-farm/
cp -r ../src/uk-farm/milk uk-farm/

comment "(5/9). Let's check again how files are structured right now"
execute "tree ."

comment "(6/9). Also, let's quickly check each new file content"
execute 'cat brazil-farm/coffee/coffee.go'
execute 'cat colombia-farm/coffee/coffee.go'
execute 'cat uk-farm/milk/milk.go'

comment "(7/9). Create a new module that depends on all 3 modules"
execute 'mkdir gocon-cafe; cd gocon-cafe; go mod init gocon.cafe'

comment_w "Let's get a main.go - firstly, import statements"
execute 'cat <<EOF >> main.go
package main

import (
	"fmt"
	"time"

	brazil_coffee "brazil.farm/coffee"
	colombia_coffee "colombia.farm/coffee"
	"uk.farm/milk"
)

EOF'

comment_w "Secondly, let's get one implementation for latte"
execute 'cat <<EOF >> main.go
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

	fmt.Printf("Here goes your Latte!\n\n-- Ingredients were:\n\t%s\n\t%s\n\n", c, m)
}

EOF'

comment_w "Let's also get another one for flat white"
execute 'cat <<EOF >> main.go
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

	fmt.Printf("Here goes your Flat White!\n\n-- Ingredients were:\n\t%s\n\t%s\n", c, m)
}

EOF'

comment "And finally, main function to call both of the functions defined above."
execute 'cat <<EOF >> main.go
func main() {
	MakeLatte()

	time.Sleep(time.Second)

	MakeFlatWhite()
}
EOF'

comment_w "Voila! Let's run it!"
execute "go run main.go"
comment_w "Like last time, we get an error - Go doesn't know where the dependencies come from"

comment_w "Let's try 'go get' command as suggested here"
execute "go get brazil.farm/coffee"
comment_w "It didn't work, because brazil.farm/coffee is not a real address"
comment_w "Here comes the replace directive"

comment "(8/9). Let's add the replace directive to the go.mod file"
execute "cat <<EOF >> go.mod
replace (
	brazil.farm => ../brazil-farm
	colombia.farm => ../colombia-farm
	uk.farm => ../uk-farm
)
EOF"
execute "cat go.mod"
comment_w "And let's try go get again"
execute "go get brazil.farm/coffee"
comment_w "It worked! Let's do the rest with go mod tidy"
execute "go mod tidy"
execute "cat go.mod"
execute "cat go.sum"

comment "(9/9). Run go run main.go again"
execute "go run main.go"
