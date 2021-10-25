import 'package:flutter/material.dart';

class ImageCaptioningPage extends StatefulWidget {

  const ImageCaptioningPage({Key? key}) : super(key: key);

  @override
  State<ImageCaptioningPage> createState() => _ImageCaptioningPageState();
}

class _ImageCaptioningPageState extends State<ImageCaptioningPage> {

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 50),
              Image.asset('images/ic.PNG'),
              SizedBox(height: 30),
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
              )
            ],
          )),
    );
  }
}
