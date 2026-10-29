#!/bin/bash
# Stop the application before installing a new revision.
set -u

fuser -k 8000/tcp 2>/dev/null || true
pkill -f 'gunicorn.*application:app' 2>/dev/null || true
pkill -f 'python3 application.py' 2>/dev/null || true
sleep 1

exit 0
