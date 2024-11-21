from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api/parking-violation', methods=['POST'])
def report_violation():
    data = request.get_json()
    license_plate = data['license_plate']
    gps_latitude = data['gps_latitude']
    gps_longitude = data['gps_longitude']
    timestamp = data['timestamp']
    return jsonify({"message": "Data received"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

