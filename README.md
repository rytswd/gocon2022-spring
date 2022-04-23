# Go Conference 2022 Spring

<img width="1355" alt="image" src="https://user-images.githubusercontent.com/23435099/164800449-9284ee34-bfc9-42c7-87b3-e83124afb5e5.png">

> Date: 23rd April, 2022
>
> Title: **Go Module with Microservices and Monorepo: Clear Dependencies with Ease of Development**
>
> Presented by [@rytswd](https://github.com/rytswd)

Official Website: https://gocon.jp/2022spring/

Original Recording: https://youtu.be/jEdIXzvw_Ao

## 🌄 About This Repository

This repository contains all the materials used in my talk of "Go Module with Microservices and Monorepo: Clear Dependencies with Ease of Development" at Go Conference 2022 - Spring. There are mainly 3 demos, and it is made in a way that anyone can easily follow most of the steps on their own.

The details of each directory is as per below.

### Demo 1: Basics of Go Module

```
demos/1-basic
├── demo.sh
└── src
    ├── go.mod
    ├── go.sum
    └── main.go
```

- `demo.sh`: A shell script made to run each command one by one when enter is pressed. You can follow the file content to run each line if you wish. The typing effect is achieved by [`/tools/demo-helper.sh`][5].
- `demo-src/`: The above `demo.sh` will create a new directory `demo-src` to start the demo from the empty directory.
- `src/`: This directory has all the files as the result of `demo.sh` run.
  - `go.mod`: List of module paths used in this Go module.
  - `go.sum`: List of direct and indirect dependencies, with cryptographic hashes for each.
  - `main.go`: Simple "Hello World" example, which has dependency to https://github.com/Code-Hex/Neo-cowsay.

### Demo 2: Details of `replace` Directive

```
demos/2-with-replace
├── demo.sh
└── src
    ├── brazil-farm
    │   ├── coffee
    │   │   └── coffee.go
    │   └── go.mod
    ├── colombia-farm
    │   ├── coffee
    │   │   └── coffee.go
    │   └── go.mod
    ├── uk-farm
    │   ├── go.mod
    │   └── milk
    │       └── milk.go
    └── gocon-cafe
        ├── go.mod
        └── main.go
```

![Demo 2 Diagram](https://user-images.githubusercontent.com/23435099/164845319-fe2c40a8-808c-4eaf-9843-6900b3d27896.png)

- `demo.sh`: A shell script made to run each command one by one when enter is pressed. You can follow the file content to run each line if you wish. The typing effect is achieved by [`/tools/demo-helper.sh`][5].
- `demo-src/`: The above `demo.sh` will create a new directory `demo-src` to start the demo from the empty directory.
- `src/`: This directory has all the files as the result of `demo.sh` run.
  - `brazil-farm/`: An example module, which defines a function `FruityCoffee()`.
  - `colombia-farm/`: An example module, which defines a function `DarkRoastedCoffee()`.
  - `uk-farm/`: An example module, which defines a function `WarmMilk()`.
  - `gocon-cafe/main.go`: Uses dependencies and runs 2 functions:
    - `MakeLatte()` - uses `FruityCoffee()` and `WarmMilk()`
    - `MakeFlatWhite()` - uses `DarkRoastedCoffee()` and `WarmMilk()`

### Demo 3: Putting All Things Together

```
demos/3-all-in-one
├── demo.sh
└── src
    ├── brazil-farm
    │   ├── coffee
    │   │   └── coffee.go
    │   └── go.mod
    ├── colombia-farm
    │   ├── coffee
    │   │   └── coffee.go
    │   └── go.mod
    ├── uk-farm
    │   ├── go.mod
    │   └── milk
    │       └── milk.go
    ├── gocon-cafe
    │   ├── go.mod
    │   ├── go.sum
    │   └── main.go
    └── gocon-restaurant
        ├── go.mod
        ├── go.sum
        └── main.go
```

![Demo 3 Diagram](https://user-images.githubusercontent.com/23435099/164851525-19bf8283-ce0b-4776-9541-84f4f8f50de0.png)

The directory structure is almost identical to `demos/2-with-replace`. The key differences are:

- `demo.sh` does not copy files, simply runs some commands directly against `src` directory (and other setup along the way)
- Each module (i.e. `brazil-farm`, `colombia-farm`, and `uk-farm`) have module path set to `go.rytswd/...`
- `gocon-cafe` uses module path reference based on Git commit, rather than `replace` directive
- `gocon-restaurant` is added first with module reference to the UK Farm commit of `5f50441`
  - This allows `gocon-restaurant` to have its own dependency management

[5]: https://github.com/rytswd/gocon2022-spring/blob/main/tools/demo-helper.sh

---

## 📑 Slides

- [Slide used for presentation][4]

[4]: https://docs.google.com/presentation/d/17LZosr5Ex_SBiyO8EM7wtwNnaCM97q1ui7V6iGYrA-w/edit?usp=sharing

## 🔎 References

- [Go Modules Reference][1] - Official documentation
- [Life of a Go module][2] by Jay Conrod, former Go team member
- [Tutorial: Getting started with multi-module workspaces][3] - Official tutorial

[1]: https://golang.org/ref/mod
[2]: https://jayconrod.com/posts/118/life-of-a-go-module
[3]: https://go.dev/doc/tutorial/workspaces

## 💫 Special Thanks

The Go gopher was designed by Renée French. Illustrations by tottie.

Thanks to the Go Conference Committee for allowing me to present 🥰
