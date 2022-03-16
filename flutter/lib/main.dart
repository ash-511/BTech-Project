import 'daily_news/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'home.dart';
import 'ic_camera.dart';
import 'daily_news/newsscreen.dart';
import 'obj_detect.dart';
import 'text_detection.dart';
import 'package:alan_voice/alan_voice.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/imgcap':(context)=> const ImageCaptioningPage(),
        '/dailynews':(context)=> DailyNewsPage(),
        '/objdetect':(context)=> const ObjectDetectionPage(),
        '/detecttext':(context)=> const TextDetectionPage(),
      },
    );
  }
}
