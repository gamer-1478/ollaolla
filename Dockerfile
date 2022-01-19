FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    open-cobol \
    python3.8 \
    python3-pip \
    gunicorn \
    nginx

RUN ./go_install.sh
WORKDIR /go-app
RUN go mod download
RUN go build -o main main.go
RUN ./main

WORKDIR /cobol
RUN cobc -free -x -o HelloWorld HelloWorld.cbl
RUN cobc -free -x -o Sorry Sorry.cbl
RUN pip install -r requirements.txt
COPY gunicorn_config.py /cobol
RUN gunicorn --worker-tmp-dir /dev/shm --config gunicorn_config.py app:app

RUN ufw allow 'Nginx HTTP'
RUN systemctl start nginx
RUN rm -rf /etc/nginx/nginx.conf
RUN cp nginx.conf /etc/nginx/nginx.conf
RUN systemctl restart nginx