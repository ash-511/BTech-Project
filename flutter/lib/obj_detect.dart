import 'package:flutter/material.dart';

class ObjectDetectionPage extends StatefulWidget {
  const ObjectDetectionPage({Key? key}) : super(key: key);

  @override
  State<ObjectDetectionPage> createState() => _ObjectDetectionPageState();
}

class _ObjectDetectionPageState extends State<ObjectDetectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Iris"),
          backgroundColor: Color(0XFF040045),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/Iris_logo.jpeg'),
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(child: Image.asset('images/od.jpg',
              height: 425,
              width: 350,
              fit: BoxFit.fill,)
              ,),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0XFFA1AFFF)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Detect",textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0XFF040045),
                        fontSize: 30, fontWeight:FontWeight.w500),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
