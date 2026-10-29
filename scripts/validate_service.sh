#!/bin/bash
# Validate that the application is healthy after deployment.
set -euxo pipefail

curl -fsS --retry 10 --retry-delay 2 --retry-connrefused http://127.0.0.1:8000/health
curl -fsS http://127.0.0.1:8000/ | grep -q 'Hello from 0oqfemca!'

echo "Application validation succeeded"
