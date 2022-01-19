FROM ubuntu:18.04

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

RUN ls -la
WORKDIR /root
RUN ls -la
RUN go build .