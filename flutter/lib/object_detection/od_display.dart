import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';

class ODDisplayPicture extends StatefulWidget {
  final String imagePath;
  final String message;
  const ODDisplayPicture({Key? key, required this.imagePath, required this.message}) : super(key: key);

  @override
  _ODDisplayPictureState createState() => _ODDisplayPictureState();
}

class _ODDisplayPictureState extends State<ODDisplayPicture> {

  FlutterTts flutterTts = FlutterTts();

  String s="Objects Detected: ";
  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      await flutterTts.speak(s+widget.message);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Future _speak(String text) async{
    //   await flutterTts.speak(text);
    // }
    return Scaffold(
        appBar: AppBar(title: const Text('Object Detection',
          style: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400),),
            backgroundColor: Color(0XFF040045),
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/Iris_logo.jpeg'),
            )
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(children: [
          SizedBox(height: 30,),
          Image.file(File(widget.imagePath),
            height: 500,
            width: 500,),
          SizedBox(height: 20,),
          Container(child: Text("Objects Detected:", style: TextStyle(fontWeight: FontWeight.w500,
              fontFamily: 'NotoSans',
              fontSize: 20.0),),),
          SizedBox(height: 10,),
          Container(child: Text(widget.message, style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'NotoSans',
              fontSize: 18.0
          ),),),
          // ElevatedButton(onPressed: () async {await _speak(widget.message);} ,
          //     child: Text("Speak"))
        ],)
    );
  }
}
