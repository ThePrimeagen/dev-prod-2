---
title: "Put it all together"
description: "Life is but a curl away..."
---

## MOAR!!
We still have not achieved maximum ease of use.  I want to be able to get the
process of bootstraping a computer going in a matter of seconds!

<br>
<br>

How do we do this?  Well... a good script can be as easy as a single curl

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## My preferred language
I am going to use Go to launch a simple http server to serve a basic bash script to:

* make sure directories have been created
* clone my repo
* run my env scripts

You can follow along in your favorite language.  Its just a server, it can be
in whatever language you chose.  Hell you could throw this up on a cdn

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

```go
package main

import (
	_ "embed"
	"log"
	"net/http"
	"os"
)

//go:embed resources/setup
var data []byte

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		_, _ = w.Write(data)
	})


	log.Println("listening on", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

```

and the resource script
```bash
#!/usr/bin/env bash
sudo apt -y update

if ! command -v git &> /dev/null; then
    sudo apt -y install git
fi

if [ ! -d $HOME/personal ]; then
    mkdir $HOME/personal
fi

git clone https://github.com/ThePrimeagen/dev $HOME/personal/dev

pushd $HOME/personal/dev
./run
popd
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Quick validation
lets see if this entire pipeline works.

* create a new repo and commit the simple runner to it
* ensure your startup script has the same git repo link
* start the server locally
* see if we can run everything

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

