#!/bin/bash
# Install Python dependencies used by the Flask application.
set -euxo pipefail

APP_DIR=/home/ec2-user/cmtr-app
cd "$APP_DIR"

/usr/bin/python3 -m pip install -r requirements.txt

/usr/bin/python3 -c 'import flask, gunicorn'
