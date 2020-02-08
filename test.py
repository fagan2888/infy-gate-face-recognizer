from time import time

import face_recognition
trump_image = face_recognition.load_image_file("trump.jpeg")
obama_image = face_recognition.load_image_file("obama.jpeg")
unkno_image = face_recognition.load_image_file("trump_1.jpeg")

trump_encoding = face_recognition.face_encodings(trump_image)[0]
obama_encoding = face_recognition.face_encodings(obama_image)[0]
t = time()
unkno_encoding = face_recognition.face_encodings(unkno_image)[0]
print(time()-t)

results = face_recognition.compare_faces([trump_encoding for x in range(50000)], unkno_encoding)

print(results)