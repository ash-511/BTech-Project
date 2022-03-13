from flask import Flask, render_template, request, jsonify
from werkzeug.utils import secure_filename
from PIL import Image
# import pickle
import os

from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.applications.xception import Xception
from keras.models import load_model
from pickle import load
import numpy as np
# from PIL import Image
from flask_restful import Resource, Api, reqparse

import tempfile
import sys
import glob
import re
import joblib

port = int(os.environ.get('PORT', 5000))
UPLOAD_FOLDER = os.getcwd() + "/images"
app = Flask(__name__)
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

@app.route("/")
def home():
  return jsonify({"message": "Hello"})

# @app.route("/uploadImage", methods=["GET", "POST"])
# def upload():
#   file = request.files['image']
#     # Read the image via file.stream
#   img = Image.open(file.stream)

#   return jsonify({'message': 'success', 'size': [img.width, img.height]})

    # if request.method == "POST":
        # print(request)
        # image = request.files["image"]
        # filename = secure_filename(image.filename)
        # return jsonify({"message":"hi"})
        # print(filename)
        # image.save(os.path.join(app.config["UPLOAD_FOLDER"], filename))
        # return jsonify({"message": "Image Uploaded Successfully"})
@app.route('/predict', methods=["GET", "POST"])
def upload():
  def extract_features(image, model):
    # try:
    # 	image = Image.open(filename)
    # except:
    # 	print("ERROR: Couldn't open image! Make sure the image path and extension is correct")
    image = image.resize((299,299))
    image = np.array(image)
    if image.shape[2] == 4:
      image = image[..., :3]
    image = np.expand_dims(image, axis=0)
    image = image/127.5
    image = image - 1.0
    feature = model.predict(image)
    return feature
  
  def word_for_id(integer, tokenizer):
    for word, index in tokenizer.word_index.items():
      if index == integer:
        return word
    return None


  def generate_desc(model, tokenizer, photo, max_length):
    in_text = 'start'
    for i in range(max_length):
      sequence = tokenizer.texts_to_sequences([in_text])[0]
      sequence = pad_sequences([sequence], maxlen=max_length)
      pred = model.predict([photo,sequence], verbose=0)
      pred = np.argmax(pred)
      word = word_for_id(pred, tokenizer)
      if word is None:
        break
      in_text += ' ' + word
      if word == 'end':
        break
    return in_text
  #path = 'Flicker8k_Dataset/111537222_07e56d5a30.jpg'
  
  max_length = 32
  # tokenizer = load(open("tokenizer.p","rb"))
  tokenizer = joblib.load("tokenizer.p")
  model = load_model('models/model_9.h5')
  xception_model = Xception(include_top=False, pooling="avg")

  # def allowed_image(fname):
  # 	if not "." in fname:
  # 		return False
  # 	ext = fname.rsplit(".", 1)[1]
  # 	if ext.upper() in app.config["ALLOWED_IMAGE_EXTENSIONS"]:
  # 		return True
  # 	else:
  # 		return False



  if request.method in ('POST', 'GET'):
    try:
      file = request.files['image']
    except:
      return jsonify({
        "message": "Image not uploaded successfully"
      })

      #fname = werkzeug.utils.secure_filename(imagefile.filename)

    # basepath = os.path.dirname(__file__)
    # file_path = os.path.join(basepath, 'uploads', fname)
    # f.save(file_path)

     
      # f = request.files['file']
      # fname=secure_filename(f.filename)

    # if allowed_image(fname):
      # 	basepath = os.path.dirname(__file__)
      # 	file_path = os.path.join(basepath, 'uploads', fname)
      # 	f.save(file_path)


    img = Image.open(file.stream)
    photo = extract_features(img, xception_model)
    description = generate_desc(model, tokenizer, photo, max_length)
    result= description[6:-3]
    # if os.path.exists(file_path):
    #   os.remove(file_path)
    return jsonify({
        "message": str(result)})
    
  # else:
  #   return 'Error occured, Please ensure you\'re using jpeg or jpg file format.' 
  # return jsonify({
  # 			"message": "Image uploaded successfully"
  # 		})
  # return None

if __name__ == "__main__":
    app.run(host = '0.0.0.0', port = port, debug=True)


# @app.route('/predict', methods=['POST'])
# def predict():
#  lr = joblib.load("model.h5")
#  with open(static_dir+'sample.jpg',"wb") as fh:
#             fh.write(base64.decodebytes(request.data))
#         captions=gc.generate_captions(static_dir+'sample.jpg')
#         cap={"captions":captions}
#         with open("text/data.json","w") as fjson:
#                     json.dump(cap,fjson)
