FROM golang:1.12.0-alpine3.9

RUN apt-get update && apt-get install -y \
    open-cobol \
    python3.8 \
    python3-pip \
    gunicorn \
    nginx \
    curl

RUN apt-get install -y \
    golang-go \
    apt-utils

RUN ls -lh /usr/bin/go
RUN go build .