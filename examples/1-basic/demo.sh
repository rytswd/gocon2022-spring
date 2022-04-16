#!/usr/bin/env bash

demo_helper_type_speed=3000

# shellcheck source=../../tools/demo-helper.sh
source "$(dirname "$0")/../../tools/demo-helper.sh"

comment "(1/9). Going into demo-src directory"
execute "mkdir demo-src; cd demo-src"

# shellcheck disable=SC2016
comment '(2/9). Run `go mod init`'
execute "go mod init github.com/rytswd/gocon2022-spring/first-example"

comment "(3/9). Check go.mod"
execute "cat go.mod"

comment "(4/9). Create a simple main.go for testing module resolution"
comment_g "-- Copying code from examples/1-basic/src/main.go"
cp ../src/main.go .
comment_g "-- Let's check its content"
execute "cat main.go"

# shellcheck disable=SC2016
comment '(5/9). Try running `go run main.go`'
execute "go run main.go"

# shellcheck disable=SC2016
comment "(6/9). Go module needs to know about the dependency details, let's run" '`go mod tidy`'
execute "go mod tidy"

comment "(7/9). Let's see what happened to go.mod"
execute "cat go.mod"

comment "(8/9). Also, we got a new file called 'go.sum'"
execute "ls -l"
execute "cat go.sum"

# shellcheck disable=SC2016
comment '(9/9). Finally, run `go run main.go` again'
execute "go run main.go"
