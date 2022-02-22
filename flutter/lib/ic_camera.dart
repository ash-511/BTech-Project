import 'dart:io';
import 'dart:async';
import 'package:NewsApp/displaypicture.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class ImageCaptioningPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const ImageCaptioningPage({this.cameras,Key? key,}) : super(key: key);
  //final String imagePath;
  @override
  State<ImageCaptioningPage> createState() => _ImageCaptioningPageState();
}

class _ImageCaptioningPageState extends State<ImageCaptioningPage> {
  late CameraController controller;
  XFile? pictureFile;
  // late Future<void> _initializeControllerFuture;

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
          title: Text('Iris'),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/Iris_logo.jpeg'),
          ),
          backgroundColor: Color(0xff060921)),
      body: Center(
          child: Column(
          children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: CameraPreview(controller),
        ),
      ),
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
    onPressed: () async {
    pictureFile = await controller.takePicture();
    // Navigator.push(context, MaterialPageRoute(builder: (context){
    // return DisplayPicture(imagePath: pictureFile!.path);
    // }));
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>DisplayPicture(imagePath: pictureFile!.path,))
    );
    setState(() {});
    },
    child: const Text('Capture Image'),
    ),
    ),
    if (pictureFile != null)
    Image.file(File(pictureFile!.path),
    height: 200,
    width: 400,),
    ButtonTheme(
    minWidth: 300,
    height: 80,
    child: RaisedButton(
    onPressed: () {},
    color: Color(0xffA1AFFF),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100)),
    child: Text(
    'Describe',
    style: TextStyle(fontSize: 30),
    ),
    ),
    ),
    ],
    ),
    ));
  }
}

