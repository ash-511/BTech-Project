import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'screen2.dart';
import 'package:alan_voice/alan_voice.dart';

class TextDetection extends StatefulWidget {
  @override
  _TextDetectionState createState() => _TextDetectionState();
}

class _TextDetectionState extends State<TextDetection> {

  _TextDetectionState() {

    String sdkKey = "f4b5ec72bdd281a7780bdbb62601ddf42e956eca572e1d8b807a3e2338fdd0dc/stage";

    Future<void> _handleCommand(Map<String, dynamic> command) async {
      switch (command["command"]) {
        case 'scan':
          //Future scanText() async {
            final inputImage = InputImage.fromFile(File(_image!.path));
            final textDetector = GoogleMlKit.vision.textDetector();
            final RecognisedText recognisedText = await textDetector.processImage(inputImage);

            for (TextBlock block in recognisedText.blocks) {
              for (TextLine line in block.lines)
              {
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
          //}
          break;
        default:
          debugPrint("Unknown command: ${command}");
      }
    }
    AlanVoice.addButton(sdkKey,buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));

  }
  String _text = '';
  String result="";
  PickedFile? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Recognition'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: Icon(Icons.add_a_photo),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null
              ? Image.file(
            File(_image!.path),
            fit: BoxFit.fitWidth,
          )
              : Container(),
        ));
  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}
