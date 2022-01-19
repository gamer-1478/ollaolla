#!/bin/sh

# service supervisord restart

cd /cobol
tmux new-session -d -s "cobol" gunicorn --worker-tmp-dir /dev/shm --config gunicorn_config.py app:app
cd /go-app
tmux new-session -d -s "go" ./main

service nginx restart

/bin/bash