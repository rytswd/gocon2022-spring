#!/usr/bin/env bash

demo_helper_type_speed=5000

# shellcheck source=../../tools/demo-helper.sh
source "$(dirname "$0")/../../tools/demo-helper.sh"

comment "1. Set up for custom domain 'go.rytswd'"
comment_w "Get into domain server directory"
execute "cd ../simple-domain-server"
comment_w "Create certificate for local testing"
execute "mkcert go.rytswd"

comment_w "Add name resolution just for local testing"
execute "sudo vi /etc/hosts # With following entry: 127.0.0.1 go.rytswd"
comment_w "Start server in the background"
execute "PORT=443 go run main.go &"
comment_w "Test server"
execute "curl https://go.rytswd/gocon-main-demo/"
comment_w "Now we have a custom domain set up to handle Go module request."
execute "cd ../3-all-in-one"

comment "2. See what we have"
execute "cd src; tree ."
comment_w "See some key differences from the 2nd demo"
execute "cat brazil-farm/go.mod"
execute "cat uk-farm/go.mod"
comment_w "GoCon Cafe now looks quite different"
execute "cat gocon-cafe/go.mod"
comment_w "There is a new service called GoCon Restaurant, too"
execute "cat gocon-restaurant/go.mod"
comment_g "Note how the commit hash is different, although they both depend on uk-farm package"

comment_w "Make sure all services compile correctly"
execute "cd gocon-cafe; go build"
execute "rm gocon-cafe; cd .."
execute "cd gocon-restaurant; go build"
execute "rm gocon-restaurant; cd .."
