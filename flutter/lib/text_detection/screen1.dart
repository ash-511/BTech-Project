import 'dart:async';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'screen2.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:camera/camera.dart';

class TextDetection extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const TextDetection({this.cameras,Key? key,}) : super(key: key);

  @override
  _TextDetectionState createState() => _TextDetectionState();
}

class _TextDetectionState extends State<TextDetection> {
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
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText = await textDetector.processImage(
        inputImage);

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          result = result + '  ' + element.text;
        }
        result = result + ' ';
      }
    }
    //print("inside scan");
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(result)));
  }

  String result = "";
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
