import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:NewsApp/Image%20Captioning/displaypicture.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

class ImageCaptioningPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const ImageCaptioningPage({this.cameras,Key? key,}) : super(key: key);
  //final String imagePath;
  @override
  State<ImageCaptioningPage> createState() => _ImageCaptioningPageState();
}

class _ImageCaptioningPageState extends State<ImageCaptioningPage> {
  late CameraController controller;
  String message= "";
  XFile? pictureFile;
  FlutterTts flutterTts = FlutterTts();
  var url=Uri.parse("https://imgcapflask.herokuapp.com/predict");
  String instruction="The image will be captured in a few seconds. Hold up your phone to such that a clear image can be captured.";

  uploadImage(File img) async{
    final request=http.MultipartRequest("POST",url);
    //final headers={"Content-type":"multipart/form-data"};
    request.files.add(http.MultipartFile('image',img.readAsBytes().asStream(),
        img.lengthSync(),filename: img.path.split("/").last));
    // http.StreamedResponse response=await request.send();
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    //latest added code
    final resJson=jsonDecode(response.body);
    message=resJson['message'];
    print(response.statusCode);
    print(message);
  }
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
    Timer(Duration(milliseconds: 10000), () async{
      pictureFile = await controller.takePicture();
      File file = File(pictureFile!.path);
      await uploadImage(file);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              DisplayPicture(imagePath: pictureFile!.path, message: message,))
      );
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
                      height: 700,
                      width: 500,
                      child: CameraPreview(controller),
                    ),
                  ),
                ),
                if (pictureFile != null)
                  Image.file(File(pictureFile!.path),
                    height: 200,
                    width: 400,),
              ],
            ),
          ));
    }
  }

