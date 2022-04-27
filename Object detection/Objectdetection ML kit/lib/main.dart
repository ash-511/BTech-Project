import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'details.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'objectdetection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed:() async{
          await availableCameras().then(
                (value)=>Navigator.push(context,
              MaterialPageRoute(builder: (context)=>objectdetection(cameras:value),
              ),
            ),
          );
        },
        child: Text('Press karo'),
      ),
    );
  }
}

