import os
from flask import Flask, request, jsonify
from dotenv import load_dotenv

# Load the variables from .env
load_dotenv()

app = Flask(__name__)
# Get the URL from the environment variable
NGROK_URL = os.getenv("NGROK_URL")

@app.route('/verify_key', methods=['POST'])
def verify_key():
    # Your logic remains the same, but now it's safer!
    print(f"Backend active at: {NGROK_URL}")
    return jsonify({"status": "active"}), 200

if __name__ == '__main__':
    app.run(port=5000)
