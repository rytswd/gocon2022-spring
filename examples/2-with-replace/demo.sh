#!/usr/bin/env bash

demo_helper_type_speed=5000

# shellcheck source=../../tools/demo-helper.sh
source "$(dirname "$0")/../../tools/demo-helper.sh"

comment "(1/8). Go into demo-src directory"
execute "mkdir demo-src; cd demo-src"

comment "(2/8). Make 3 directories, each as a module"
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

comment "(3/8). Check how the files are structured right now"
execute "tree ."

comment "(4/8). Add some implementation code for each module"
comment_g "-- Copying code from examples/2-with-replace/src, which has each module defined the same way."
cp -r ../src/brazil-farm/coffee brazil-farm/
cp -r ../src/colombia-farm/coffee colombia-farm/
cp -r ../src/uk-farm/milk uk-farm/

comment_w "Check again how files are structured right now"
execute "tree ."

comment_w "And each new file content"
execute 'cat brazil-farm/coffee/coffee.go'
execute 'cat colombia-farm/coffee/coffee.go'
execute 'cat uk-farm/milk/milk.go'

comment "(5/8). Create a new module that depends on all 3 modules"
execute "mkdir gocon-cafe; cd gocon-cafe"
execute "go mod init gocon.cafe"
comment_g "-- Copying main.go from examples/2-with-replace/src"
cp -r ../../src/gocon-cafe/main.go .
execute "tree ."
execute 'cat main.go'

comment "(6/8). Try running main.go"
execute "go run main.go"
comment_w "OK, Go doesn't know where the dependencies come from"

comment_w "Try 'go get' command as suggested here"
execute "go get brazil.farm/coffee"
comment_w "It didn't work, because brazil.farm/coffee is not a real address"
comment_w "Here comes the replace directive"

comment "(7/8). Let's add the replace directive to the go.mod file"
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

comment "(8/8). Run go run main.go again"
execute "go run main.go"
