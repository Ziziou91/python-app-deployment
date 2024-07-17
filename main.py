from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/webhook', methods=['GET', 'POST'])
def webhook():
    print("Hello world!")
    print(f"received {request.method}")
    if request.method == "POST":
        data = request.json
        # Process the data as needed
        print(f"Received webhook data: {data}")
        # Respond to the webhook request
        return jsonify({"status": "success", "data": data}), 200
    elif request.method == "GET":
        # data = request.json
        print("Received GET request")
        return jsonify({"status": "success", "data": "Received GET request"}), 200
    else:
        return jsonify({"status": "failure", "message": "Method not allowed"}), 405


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)