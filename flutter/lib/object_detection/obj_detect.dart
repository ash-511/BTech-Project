import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'od_display.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

class ObjectDetectionPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const ObjectDetectionPage({this.cameras,Key? key,}) : super(key: key);

  @override
  State<ObjectDetectionPage> createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends State<ObjectDetectionPage> {
  late CameraController controller;
  List<dynamic> message=[];
  String res="";
  XFile? pictureFile;
  var url=Uri.parse("https://objdetflask.herokuapp.com/upload");

  FlutterTts flutterTts = FlutterTts();
  String instruction="The image will be captured in a few seconds. Hold up your phone to such that a clear image can be captured to detect the objects in frame.";

  uploadImage(File img) async{
    final request=http.MultipartRequest("POST",url);
    //final headers={"Content-type":"multipart/form-data"};
    request.files.add(http.MultipartFile('file',img.readAsBytes().asStream(),
        img.lengthSync(),filename: img.path.split("/").last));
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    final resJson=jsonDecode(response.body);

    print('${resJson.runtimeType} : $resJson');
    //Map<String, dynamic> user = resJson;
    //print('first message, ${user['objects_count']}!');
    //message=resJson["objects_count"];
    print("hell0");
    print('$resJson');
    message=resJson['detections'];
    print(message);
    for(var i in message){
      res=res+i+",";
    }
    print("hello2");
    print(response.statusCode);
    print(res);
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
              ODDisplayPicture(imagePath: pictureFile!.path, message: res,))
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
            title: Text('Object Detection',
              style: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400),),
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
                    height: 710,
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

