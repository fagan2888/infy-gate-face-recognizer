import pickle
from time import time

import cv2

import face_recognition
import numpy
from flask import *

app = Flask(__name__)


def load_encodings():
    try:
        file = open('encodings.pkl', 'rb')
        encodings = pickle.load(file)
        file.close()
    except:
        encodings = {}
    keys, values = [], []
    for k in encodings.keys():
        for v in encodings[k]:
            keys.append(k)
            values.append(v)
            # print(len(v))
    return encodings, keys, values


encodings, enc_keys, enc_vals = load_encodings()


def add_encodings(key, val):
    if key not in encodings.keys():
        encodings[key] = []
    encodings[key].append(val)
    pickle_out = open("encodings.pkl", "wb")
    pickle.dump(encodings, pickle_out)
    pickle_out.close()
    enc_keys.append(key)
    enc_vals.append(val)


def encoder(bin):
    img = numpy.fromstring(bin, numpy.uint8)
    img = cv2.imdecode(img, cv2.IMREAD_UNCHANGED)
    # img = cv2.resize(img, (640, 480))
    max = 0
    idx = 0
    try:
        face_locations = face_recognition.face_locations(img)
        for i in range(len(face_locations)):
            location = face_locations[i]
            top, right, bottom, left = location
            area = abs(right - left) * abs(bottom - top)
            if area > max:
                max = area
                idx = i
        return face_recognition.face_encodings(img, [face_locations[idx]])[0]
    except:
        return None


@app.route('/encoding', methods=['GET'])
def encoding_get():
    return render_template("encoding.html")


@app.route('/encoding', methods=['POST'])
def encoding_post():
    if request.method == 'POST':
        name = request.form['name']
        encoding = encoder(request.files['file'].read())
        print(name)
        add_encodings(name, encoding)
        return "saved"


@app.route('/identity', methods=['GET'])
def identity_get():
    return render_template("identity.html")


@app.route('/identity', methods=['POST'])
def identity_post():
    if request.method == 'POST':
        results = face_recognition.compare_faces(enc_vals, encoder(request.files['file'].read()))
        index = [k for k, v in enumerate(results) if v == True]
        try:
            return str(enc_keys[index[0]])
        except:
            return "not-found"



@app.route('/id', methods=['POST'])
def id_post():
    if request.method == 'POST':
        data = encoder(request.data)
        if data is not None:
            results = face_recognition.compare_faces(enc_vals, data)
            index = [k for k, v in enumerate(results) if v == True]
            try:
                return jsonify(identity=str(enc_keys[index[0]]))
            except:
                return jsonify(identity="not-found")
        return jsonify(identity="not-found")


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
