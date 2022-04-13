import 'package:flutter/material.dart';
import 'home.dart';
import 'Image Captioning/ic_camera.dart';
import 'daily_news/newsscreen.dart';
import 'object_detection/obj_detect.dart';
import 'text_detection/screen1.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/imgcap':(context)=> ImageCaptioningPage(),
        '/dailynews':(context)=> DailyNewsPage(),
        '/objdetect':(context)=> ObjectDetectionPage(),
        '/detecttext':(context)=> TextDetection(),
      },
      //onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
