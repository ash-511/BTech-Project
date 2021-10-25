import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screens/home.dart';
import 'package:alan_voice/alan_voice.dart';

void main() {
  runApp(Iris());
}

class Iris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFFFFFFFF),
      ),
      home: MyHomePage(),
    );
  }
}
