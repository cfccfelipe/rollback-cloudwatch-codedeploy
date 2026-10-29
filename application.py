import os

from flask import Flask, request

app = Flask(__name__)

APP_VERSION = os.environ.get("APP_VERSION", "bad-rollback-test")


@app.route("/")
def home():
    # The verification string must remain present on the main page.
    return "Hello from 0oqfemca!"


@app.route("/health")
def health():
    # Temporary rollback test: pass local lifecycle validation but fail the
    # ALB target group health check so the ALBUnhealthy alarm fires.
    ua = request.headers.get("User-Agent", "")
    if "ELB-HealthChecker" in ua:
        return "unhealthy", 503
    return "OK", 200


@app.route("/version")
def version():
    return APP_VERSION, 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
