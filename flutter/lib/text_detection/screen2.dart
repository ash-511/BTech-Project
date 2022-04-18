import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String text;
  Details(this.text);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  FlutterTts flutterTts = FlutterTts();
  //String res="";

  @override
  void initState() {
    Future.delayed(Duration.zero,() async {
      await flutterTts.speak(widget.text);
    });
    super.initState();
  }

  // Future<void> initState() async {
  //   super.initState();
  //   await flutterTts.speak(widget.text);
  //
  // }


  Future _speak(String text) async{
    await flutterTts.speak(text);
  }
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Text Recognition',
            style: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400),),
            backgroundColor: Color(0XFF040045),
            leading: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/Iris_logo.jpeg'),
            )
        ),
        body: Column(
          children: [
            SizedBox(height: 20.0,),
            Container(child: Text("Scanned Text:",
              style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),),),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              height: 710,
              width: 500,
              child: SelectableText(
                  widget.text.isEmpty ? 'No Text Available' : widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'NotoSans',
                  fontSize: 15.0
                ),),
            ),
          ],
        )
    );
  }
}
