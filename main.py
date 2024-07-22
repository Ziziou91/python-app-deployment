import requests
import json
from flask import Flask, request, jsonify

webhook_url = "https://webhook.site/4f96fb8c-9973-4dbe-9397-cff9af9fc437"

app = Flask(__name__)

@app.route('/webhook', methods=['GET', 'POST'])
def webhook():


    if request.method == "POST":
        req_data = request.json
        # Process the data as needed

        # Check that the request is coming from the repo
        if req_data["repository"]["url"] == "https://api.github.com/repos/Ziziou91/python-app-deployment":
            data = { 'name': 'This is a test of my webhook' }
            requests.post(webhook_url, data=json.dumps(data), headers={'Content-Type': 'application/json'})
            return jsonify({"status": "success", "data": "received github webhook"}), 200



        return jsonify({"status": "success", "data": data}), 200
    

    elif request.method == "GET":
        # data = request.json
        print("Received GET request")
        return jsonify({"status": "success", "data": "Received GET request"}), 200
    else:
        return jsonify({"status": "failure", "message": "Method not allowed"}), 405


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
    