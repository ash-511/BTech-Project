import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'object_detection/obj_detect.dart';
import 'Image Captioning/ic_camera.dart';
import 'text_detection/screen1.dart';
import 'daily_news/newsscreen.dart';
import 'package:alan_voice/alan_voice.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);
  //final CameraDescription camera;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {

    String sdkKey = "f4b5ec72bdd281a7780bdbb62601ddf42e956eca572e1d8b807a3e2338fdd0dc/stage";

    Future<void> _handleCommand(Map<String, dynamic> command) async {
      switch (command["command"]) {
        case "obj_detect":
          //Navigator.pushNamed(context,'/objdetect');
            await availableCameras().then(
                  (value)=>Navigator.push(context,
                MaterialPageRoute(builder: (context)=>ObjectDetectionPage(cameras:value,),
                ),
              ),
            );
          break;
        case "img_cap":
          //Navigator.pushNamed(context,'/imgcap');
          await availableCameras().then(
                  (value)=>Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>ImageCaptioningPage(cameras:value,),
                  ),
              ),
          );
          break;
        // case "txt_detect":
        //   Navigator.pushNamed(context,'/detecttext');
        //   break;
        case "daily_news":
          Navigator.pushNamed(context,'/dailynews');
          break;
        case "home":
          Navigator.pop(context);
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
          title: Text("Iris",
            style: TextStyle(
                fontFamily: 'NotoSans',
              fontWeight: FontWeight.w400),
          ),
          backgroundColor: Color(0XFF040045),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/Iris_logo.jpeg'),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              radius: 85,
              backgroundImage:AssetImage('images/Iris_logo.jpeg') ,
            ),
            Container(child: Text("IRIS",
              style: TextStyle(
                  fontSize: 35,
                fontWeight: FontWeight.w500,
                fontFamily: 'NotoSans',
              ),
            ),
            ),
            GestureDetector(
              onTap: () async{
                await availableCameras().then(
                      (value)=>Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>ObjectDetectionPage(cameras:value,),
                    ),
                  ),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Color(0XFFA1AFFF)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(Icons.visibility),
                    SizedBox(
                      width: 17.0,
                    ),
                    Text("Object Detection",
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,
                      fontSize: 20.0),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                await availableCameras().then(
                      (value)=>Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>ImageCaptioningPage(cameras:value,),
                    ),
                  ),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Color(0XFFA1AFFF)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(Icons.image),
                    SizedBox(
                      width: 17.0,
                    ),
                    Text("Image captioning",
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                await availableCameras().then(
                      (value)=>Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>TextDetection(cameras:value,),
                    ),
                  ),
                );
              },
              // {Navigator.push(context, MaterialPageRoute(builder: (context){
              //   return TextDetection();}));
              //   },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Color(0XFFA1AFFF)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(Icons.description),
                    SizedBox(
                      width: 17.0,
                    ),
                    Text("Text Recognition",
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return DailyNewsPage();
                }),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Color(0XFFA1AFFF)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.0,
                    ),
                    Icon(Icons.newspaper),
                    SizedBox(
                      width: 17.0,
                    ),
                    Text("Daily News",
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

