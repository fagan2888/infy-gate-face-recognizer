import os
from os.path import isfile, join
from time import time

import face_recognition
from joblib import Parallel, delayed
import multiprocessing

files = [f for f in os.listdir('./images') if isfile(join('./images', f))]
encodings = {}

def processInput(file):
    print(file)
    image = face_recognition.load_image_file('./images/' + file)
    print(type(image))
    encoding = face_recognition.face_encodings(image)[0]
    return file.replace('.jpg', ''), encoding

#
# num_cores = multiprocessing.cpu_count()
x = time()
results = Parallel(n_jobs=len(files))(delayed(processInput)(file) for file in files)

print(time()-x)

#
# pickle_out = open("encodings_old_1.pkl","wb")
# pickle.dump(encodings, pickle_out)
# pickle_out.close()
