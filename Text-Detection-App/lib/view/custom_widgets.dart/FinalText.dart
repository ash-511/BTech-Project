import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:text_recognition/model/data_layer.dart';
import 'package:text_recognition/repositories/text_recongnize.dart';


class FinalText extends StatefulWidget {
  const FinalText({Key? key}) : super(key: key);

  @override
  State<FinalText> createState() => _FinalTextState();
}

class _FinalTextState extends State<FinalText> {
  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(""),
    );
  }
}

