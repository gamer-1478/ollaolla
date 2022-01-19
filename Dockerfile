FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    open-cobol \
    python3.8 \
    python3-pip \
    gunicorn \
    nginx \
    curl \
    apt-utils \
    tmux \
    systemd

COPY . /
ADD go-app /go-app/
ADD cobol /cobol/
RUN chmod +x go_install.sh
RUN ./go_install.sh
WORKDIR /go-app
RUN /usr/local/go/bin/go build -o main .

WORKDIR /cobol
RUN cobc -free -x -o HelloWorld HelloWorld.cbl
RUN cobc -free -x -o Sorry Sorry.cbl
RUN pip3 install -r requirements.txt
COPY gunicorn_config.py /cobol

WORKDIR /
RUN rm -rf /etc/nginx/nginx.conf
RUN cp nginx.conf /etc/nginx/nginx.conf

RUN chmod +x start.sh
CMD ./start.sh