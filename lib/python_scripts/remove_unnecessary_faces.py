import subprocess
import sys
import os
import face_recognition
import glob
import re
import time
import os
import platform
import pdb
from pprint import pprint
from datetime import datetime

print("remove_unnecessary_faces.py start")

# 用意
work = sys.argv[1] + "/"
num = sys.argv[2]
a_extract = work + "a_faces_" + num + "/*"

paths = glob.glob(a_extract)
if len(paths) == 0:
    print("顔が検出できませんでした。")
    sys.exit(0)

ok_paths = []
ng_paths = []
not_face_paths = []
face_encodings_all = []
false_counts = {}

# 全ての顔のencodingsを集める
for path in paths:
    print(path)
    face_image = face_recognition.load_image_file(path)
    face_encodings = face_recognition.face_encodings(face_image)
    if face_encodings:
        face_encodings_all.append(face_encodings[0])

# 全てのファイルを判定
for path in paths:
    face_image = face_recognition.load_image_file(path)
    face_encodings = face_recognition.face_encodings(face_image)

    if not face_encodings:
        not_face_paths.append(path)
        continue

    is_same = face_recognition.compare_faces(face_encodings_all, face_encodings[0])
    false_count = is_same.count(False)
    false_counts[path] = false_count

# 平均値との比較
values = false_counts.values()
avg = sum(values) / len(values)
for path, false_count in false_counts.items():
    if false_count > avg:
        ng_paths.append(path)
    else:
        ok_paths.append(path)

# ファイルを振り分ける
for i, path in enumerate(ok_paths):
    subprocess.run(["cp", path, work + f"1_ok_{num}/{i}_{num}.png"])

for i, path in enumerate(ng_paths):
    subprocess.run(["cp", path, work + f"2_ng_{num}/{i}_{num}.png"])

for i, path in enumerate(not_face_paths):
    subprocess.run(["cp", path, work + f"3_not_face_{num}/{i}_{num}.png"])

print("remove_unnecessary_faces.py end")
