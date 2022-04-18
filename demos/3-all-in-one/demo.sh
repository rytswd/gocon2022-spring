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
execute "tree src"
comment_w "See some key differences from the 2nd demo"
