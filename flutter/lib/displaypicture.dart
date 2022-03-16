import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'ic_camera.dart';
import 'dart:io';

class DisplayPicture extends StatefulWidget {
  final String imagePath;
  const DisplayPicture({Key? key, required this.imagePath}) : super(key: key);

  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
    // The image is stored as a file on the device. Use the `Image.file`
    // constructor with the given path to display the image.
    body: Column(children: [
      Image.file(File(widget.imagePath),
        height: 500,
        width: 500,),
      SizedBox(height: 20,),
      Container(child: Text(""),)
    ],)
    );
  }
}
