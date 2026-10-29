#!/bin/bash
# Start the Flask application with gunicorn on port 8000.
set -euxo pipefail

APP_DIR=/home/ec2-user/cmtr-app
LOG_FILE=/var/log/cmtr-app.log

fuser -k 8000/tcp 2>/dev/null || true
pkill -f 'gunicorn.*application:app' 2>/dev/null || true
sleep 1

cd "$APP_DIR"

if command -v runuser >/dev/null 2>&1; then
  nohup runuser -u ec2-user -- /usr/bin/python3 -m gunicorn \
    --chdir "$APP_DIR" --bind 0.0.0.0:8000 --workers 2 --timeout 30 \
    application:app > "$LOG_FILE" 2>&1 &
else
  nohup /usr/bin/python3 -m gunicorn \
    --chdir "$APP_DIR" --bind 0.0.0.0:8000 --workers 2 --timeout 30 \
    application:app > "$LOG_FILE" 2>&1 &
fi

for _ in $(seq 1 20); do
  if curl -fsS http://127.0.0.1:8000/health >/dev/null 2>&1; then
    exit 0
  fi
  sleep 2
done

echo "Application failed to start" >&2
tail -n 100 "$LOG_FILE" >&2 || true
exit 1
