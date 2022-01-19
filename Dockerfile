FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    open-cobol \
    python3.8 \
    python3-pip \
    gunicorn \
    nginx \
    curl

RUN mkdir -p /scripts
COPY go_install.sh /scripts
WORKDIR /scripts
RUN chmod +x go_install.sh
RUN ./go_install.sh

ADD go-app /usr/local/go/bin

WORKDIR /usr/local/go/bin
RUN /usr/local/go/bin/go build /usr/local/go/bin/go-app/main.go
RUN tmux new-session -d -s "go" ./usr/local/go/bin/go-app/main

WORKDIR /cobol
RUN cobc -free -x -o HelloWorld HelloWorld.cbl
RUN cobc -free -x -o Sorry Sorry.cbl
RUN pip install -r requirements.txt
COPY gunicorn_config.py /cobol
RUN tmux new-session -d -s "cobol" gunicorn --worker-tmp-dir /dev/shm --config gunicorn_config.py app:app

RUN ufw allow 'Nginx HTTP'
RUN systemctl start nginx
RUN rm -rf /etc/nginx/nginx.conf
RUN cp nginx.conf /etc/nginx/nginx.conf
RUN systemctl restart nginx