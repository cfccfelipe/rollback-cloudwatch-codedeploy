import os

from flask import Flask

app = Flask(__name__)

APP_VERSION = os.environ.get("APP_VERSION", "1.0.0")


@app.route("/")
def home():
    # The verification string must remain present on the main page.
    return "Hello from 0oqfemca!"


@app.route("/health")
def health():
    return "OK", 200


@app.route("/version")
def version():
    return APP_VERSION, 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
