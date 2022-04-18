package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	// Specific handling for `go.rytswd/gocon-main-demo`.
	http.HandleFunc("/gocon-main-demo/", func(w http.ResponseWriter, r *http.Request) {
		t := `<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="go-import" content="go.rytswd/gocon-main-demo git https://github.com/rytswd/gocon2022-spring/examples/3-all-in-one">
    </head>
    <body>
        Hello Go Conference!
    </body>
</html>`
		w.Write([]byte(t))
		w.WriteHeader(http.StatusOK)
	})

	// Defaults to no meta tag page.
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		t := `<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    </head>
    <body>
        Hello Go Conference! This is the default page, and does not have meta tag with "go-import".
    </body>
</html>`
		w.Write([]byte(t))
		w.WriteHeader(http.StatusOK)
	})

	// If you need to test this locally, do the following:
	//   - Run `mkcert go.rytswd` in this directory
	//   - Update `/etc/hosts` to add the following line
	//       127.0.0.1 go.rytswd
	//     This adds a dummy address of `go.rytswd` to loopback to your
	//     localhost.
	//   - Use the following `http.ListenAndServeTLS` to set up TLS server
	//     instead of simple `http.ListenAndServe`
	//   - Run this file with `go run ./main.go`
	log.Fatal(http.ListenAndServeTLS(":"+os.Getenv("PORT"), "go.rytswd.pem", "go.rytswd-key.pem", nil))
	// If you are deploying this on some server with extra TLS setup, you would
	// need to use the following.
	// log.Fatal(http.ListenAndServe(":"+os.Getenv("PORT"), nil))
}
