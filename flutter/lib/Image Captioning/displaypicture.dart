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
    return Scaffold(
        appBar: AppBar(title: const Text('Image Captioning'),
            backgroundColor: Color(0XFF040045),
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/Iris_logo.jpeg'),
            )),

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
