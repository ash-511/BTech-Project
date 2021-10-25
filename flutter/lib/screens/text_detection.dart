import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextDetectionPage extends StatefulWidget {
  const TextDetectionPage({Key? key}) : super(key: key);
  @override
  State<TextDetectionPage> createState() => _TextDetectionPageState();
}

class _TextDetectionPageState extends State<TextDetectionPage> {
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
            Container(
              child: Image.asset(
                'images/text detection.jfif',
                height: 425,
                width: 350,
                fit: BoxFit.fill,
              ),
            ),
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
                  child: Text(
                    "Detect Text",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0XFF040045),
                        fontSize: 30,
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