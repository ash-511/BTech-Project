
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'details.dart';
import 'package:flutter_tts/flutter_tts.dart';


class objectdetection extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const objectdetection({this.cameras,Key? key}) : super(key: key);

  @override
  State<objectdetection> createState() => _objectdetectionState();
}

class _objectdetectionState extends State<objectdetection> {
  String result="";
  late CameraController controller;
  File? file;
  Future getImage() async {
    final pickedFile = await controller.takePicture();
    file = File(pickedFile!.path);
    print("inside get image");
    scanText(file);
    setState(() {});
  }
  Future scanText(File? file) async {
    final inputImage = InputImage.fromFile(file!);
    final imageLabeler = GoogleMlKit.vision.imageLabeler();
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels){

  result=result+label.label + " ";

    }
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(result)));
  }

  PickedFile? _image;
  final picker = ImagePicker();
  FlutterTts flutterTts = FlutterTts();
  String instruction = "The image will be captured in a few seconds. Hold up your phone such that a clear image can be captured.";




  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    Timer(Duration(milliseconds: 10000), () async {
      getImage();
      setState(() {});
    });
    flutterTts.setSpeechRate(0.4);
    flutterTts.speak(instruction);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition'),
        backgroundColor: Color(0XFF040045),
        leading: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('images/Iris_logo.jpeg'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: 710,
                  width: 500,
                  child: CameraPreview(controller),
                ),
              ),
            ),
            if (_image != null)
              Image.file(File(_image!.path),
                height: 200,
                width: 400,),
          ],
        ),
      ),
    );
  }
}











