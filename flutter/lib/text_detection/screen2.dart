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
  Future _speak(String text) async{
    await flutterTts.speak(text);
  }
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text('Details'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 500,
              width: 500,
              child: SelectableText(
                  widget.text.isEmpty ? 'No Text Available' : widget.text),
            ),
            ElevatedButton(onPressed: () async {await _speak(widget.text);}, child: Text("Speak"),)
          ],
        )
    );
  }
}