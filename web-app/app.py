from flask import Flask, jsonify
import socket

app = Flask(__name__)

@app.route("/api/ping", methods=["GET"])
def ping():
    hostname = socket.gethostname()
    return jsonify({
        "hostname": hostname,
        "message": "pong"
    })

if __name__ == "__main__":
    # Runs on all network interfaces, port 8080 by default
    app.run(host="0.0.0.0", port=8080)
    # Adding a new line
