import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screens/obj_detect.dart';
import 'package:untitled/screens/img_caption.dart';
import 'package:untitled/screens/daily_news.dart';
import 'package:untitled/screens/text_detection.dart';
import 'package:alan_voice/alan_voice.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() {
    String sdkKey = "6c174bba7c1414e273b170053db7be702e956eca572e1d8b807a3e2338fdd0dc/stage";

    void _navigateTo(String screen) {
      switch (screen) {
        case "obj_detect":
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ObjectDetectionPage();
          }),
          );
          break;
        case "img_cap":
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ImageCaptioningPage();
          }),
          );
          break;
        case "text_detect":
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return TextDetectionPage();
          }),
          );
          break;
        case "daily_news":
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return DailyNews();
          }),
          );
          break;
        case "home":
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return MyHomePage();
          }),
          );
          break;
      }
    }
    void _handleCommand(Map<String, dynamic> command) {
      switch (command["command"]) {
        case "obj_detect":
          _navigateTo(command["route"]);
          break;
        default:
          debugPrint("Unknown command: ${command}");
      }
    }
    AlanVoice.addButton(sdkKey,buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
    AlanVoice.onCommand.add((command) => _handleCommand(command.data));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Iris"),
          backgroundColor: Color(0XFF040045),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/Iris_logo.jpeg'),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ObjectDetectionPage();
                }),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0XFFA1AFFF)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Object Detection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0XFF040045),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ImageCaptioningPage();
                }),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0XFFA1AFFF)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Image Captioning",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0XFF040045),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return TextDetectionPage();
                }),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0XFFA1AFFF)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Text Detection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0XFF040045),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DailyNews();
                }),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0XFFA1AFFF)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Daily News",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0XFF040045),
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
