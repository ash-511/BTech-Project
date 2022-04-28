from flask import Flask, jsonify, request
from yolo_detection_images import detectObjects
from werkzeug.utils import secure_filename
from PIL import Image
from flask_cors import CORS
from datetime import datetime
import os
from random import randint

UPLOAD_FOLDER = os.getcwd() + "/images"
app=Flask(__name__)
app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

CORS(app)
# uploads_dir = os.path.join(app.instance_path, 'uploads')
# output_dir = os.path.join(app.instance_path, 'output')

@app.route('/upload', methods=['GET','POST'])
def detect():
  # try:
  #   os.mkdir(uploads_dir)
  #   os.mkdir(output_dir)
  # except:
  #   pass
  
  if request.method in ('POST','GET'):
    try:
      file = request.files['file']
    except:
      return jsonify({
        "message": "Image not uploaded successfully"
      })

    fname = secure_filename(file.filename)
    basepath = os.path.dirname(__file__)
    file_path = os.path.join(basepath, 'uploads', fname)
    file.save(file_path)
  # if not file:
  #   return {'error': 'Missing file'}, 400
    
  # now = datetime.now()
  # filename = now.strftime("%Y%m%d_%H%M%S") + "_" + str(randint(000, 999))
  # file.save(os.path.join(uploads_dir, secure_filename(filename + '.jpg')))
  # objects_count, objects_confidence = process(uploads_dir, output_dir, filename)
    
  results=detectObjects(file_path)

  return jsonify(results)


port = int(os.environ.get('PORT', 5000))

if __name__ == "__main__":
  app.run(host = '0.0.0.0', port = port, debug=True)
