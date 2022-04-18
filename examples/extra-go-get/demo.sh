#!/usr/bin/env bash

demo_helper_type_speed=5000

# shellcheck source=../../tools/demo-helper.sh
source "$(dirname "$0")/../../tools/demo-helper.sh"

__temp_dir=$(mktemp -d)
cd "$__temp_dir" || exit 2

# shellcheck disable=SC2016
comment 'Reproducing `go get golang.org/x/mod@latest` behaviour'
comment_w 'Huge thanks to Jay Conrod for detailed explanation on this.
    Ref: https://jayconrod.com/posts/118/life-of-a-go-module
'
comment_w "Firstly, get the versions"
execute "curl -L https://proxy.golang.org/golang.org/x/mod/@v/list"

comment_w "Let's use the latest version v0.5.1, get the go.mod file for golang.org/x/mod"
execute "curl -L https://proxy.golang.org/golang.org/x/mod/@v/v0.5.1.mod"

comment_w "Finally, get the zipped code of golang.org/x/mod"
execute "curl -L -O https://proxy.golang.org/golang.org/x/mod/@v/v0.5.1.zip"
execute "unzip -l v0.5.1.zip | head"
