#!/bin/bash

VERSION="1.15.5"
ARCH="amd64"

curl -O -L "https://golang.org/dl/go${VERSION}.linux-${ARCH}.tar.gz"
tar -xf "go${VERSION}.linux-${ARCH}.tar.gz"

chown -R root:root ./go
mv -v go /usr/local

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

/usr/local/go/bin/go mod download
/usr/local/go/bin/go build -o main main.go
./main