import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';

class DisplayPicture extends StatefulWidget {
  final String imagePath;
  final String message;
  const DisplayPicture({Key? key, required this.imagePath, required this.message}) : super(key: key);

  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      await flutterTts.speak(widget.message);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future _speak(String text) async{
    //   await flutterTts.speak(text);
    // }
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
    // The image is stored as a file on the device. Use the `Image.file`
    // constructor with the given path to display the image.
    body: Column(children: [
      Image.file(File(widget.imagePath),
        height: 500,
        width: 500,),
      SizedBox(height: 20,),
      Container(child: Text(widget.message, style: TextStyle(fontSize: 15),)),
      // ElevatedButton(onPressed: () async {await _speak(widget.message);} ,
      //     child: Text("Speak"))
    ],)
    );
  }
}
